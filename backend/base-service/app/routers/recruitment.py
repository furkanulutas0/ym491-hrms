from fastapi import APIRouter, Depends, HTTPException, status, Query, Body
from sqlalchemy.orm import Session
from typing import List, Optional
from datetime import date, datetime, timedelta
import httpx
import json
import logging
import os
import hmac
import hashlib

# Configure logging
logger = logging.getLogger(__name__)

from ..database import get_db
from ..dependencies import get_current_active_user, oauth2_scheme
from ..models.user import User
from ..models.recruitment import (
    JobPosting, JobApplication, JobApplicationNote, JobPostingNote, 
    JobPostingActivity, JobPostingDailyStats
)
from ..models.candidate import (
    Candidate, CandidateWorkExperience, CandidateEducation, 
    CandidateTechnicalSkill, CandidateSoftSkill, CandidateRawData
)
from ..schemas.recruitment import (
    JobPostingCreate, JobPostingUpdate, JobPosting as JobPostingSchema,
    JobApplicationCreate, JobApplicationUpdate, JobApplication as JobApplicationSchema,
    JobApplicationNoteCreate, JobApplicationNote as JobApplicationNoteSchema,
    JobPostingNoteCreate, JobPostingNote as JobPostingNoteSchema,
    JobPostingDailyStats as JobPostingDailyStatsSchema,
    PipelineStageUpdate, AIReviewResult, ExamAssignment, ExamResult,
    AIInterviewSchedule, DocumentUpdate, ProposalData,
    ExamWebhookEvent, CreateCandidateExamRequest
)



router = APIRouter(
    prefix="/recruitment",
    tags=["recruitment"],
    responses={404: {"description": "Not found"}},
)

# --- Job Postings ---

@router.get("/jobs", response_model=List[JobPostingSchema])
def get_job_postings(
    skip: int = 0,
    limit: int = 100,
    status: Optional[str] = None,
    department: Optional[str] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    query = db.query(JobPosting)
    if status:
        query = query.filter(JobPosting.status == status)
    if department:
        query = query.filter(JobPosting.department == department)
    return query.offset(skip).limit(limit).all()

@router.post("/jobs", response_model=JobPostingSchema)
def create_job_posting(
    job: JobPostingCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    db_job = JobPosting(**job.dict(), created_by=current_user.id)
    db.add(db_job)
    db.commit()
    db.refresh(db_job)
    
    # Log activity
    log_activity(db, db_job.id, current_user.id, "CREATE", "Job posting created")
    
    return db_job

@router.get("/jobs/{job_id}", response_model=JobPostingSchema)
def get_job_posting(
    job_id: int,
    db: Session = Depends(get_db),
    # Public endpoint, no auth required
):
    job = db.query(JobPosting).filter(JobPosting.id == job_id).first()
    if not job:
        raise HTTPException(status_code=404, detail="Job posting not found")
    return job

@router.put("/jobs/{job_id}", response_model=JobPostingSchema)
def update_job_posting(
    job_id: int,
    job_update: JobPostingUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    db_job = db.query(JobPosting).filter(JobPosting.id == job_id).first()
    if not db_job:
        raise HTTPException(status_code=404, detail="Job posting not found")
    
    update_data = job_update.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_job, key, value)
    
    db.add(db_job)
    db.commit()
    db.refresh(db_job)
    
    # Log activity
    log_activity(db, job_id, current_user.id, "UPDATE", f"Job posting updated: {', '.join(update_data.keys())}")
    
    return db_job

# --- Applications ---

@router.get("/jobs/{job_id}/applications", response_model=List[JobApplicationSchema])
def get_job_applications(
    job_id: int,
    status: Optional[str] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    # Check if job exists
    if not db.query(JobPosting).filter(JobPosting.id == job_id).first():
        raise HTTPException(status_code=404, detail="Job posting not found")
        
    query = db.query(JobApplication).filter(JobApplication.job_posting_id == job_id)
    if status:
        query = query.filter(JobApplication.status == status)
    return query.all()

@router.post("/applications", response_model=JobApplicationSchema)
async def create_application(
    application: JobApplicationCreate,
    db: Session = Depends(get_db)
    # No auth required for candidates applying? 
    # For now, let's assume this is an internal endpoint or we allow public access.
    # If public, remove current_user dependency. 
    # If this is "HR adding a candidate", keep it.
    # I'll keep it authenticated for this dashboard-focused task, or optional.
    # Let's assume authenticated for now as it's in the dashboard router context.
):
    # Verify job exists
    job = db.query(JobPosting).filter(JobPosting.id == application.job_posting_id).first()
    if not job:
        raise HTTPException(status_code=404, detail="Job posting not found")

    # Save candidate CV data to candidate tables if analyzed_cv_data is provided
    candidate_id = None
    analyzed_cv_data = application.analyzed_cv_data
    
    if analyzed_cv_data:
        try:
            # Call io-service to save candidate data
            io_service_url = "http://io-service:8000/api/io/cv/save-analyzed-cv"
            
            async with httpx.AsyncClient() as client:
                response = await client.post(
                    io_service_url,
                    json=analyzed_cv_data,
                    timeout=30.0
                )
                
                if response.status_code == 200:
                    result = response.json()
                    candidate_id = result.get("candidate_id")
                    logger.info(f"Candidate CV data saved with ID: {candidate_id}")
                else:
                    logger.error(f"Failed to save candidate CV data: {response.status_code} - {response.text}")
                    
        except Exception as e:
            logger.error(f"Error saving candidate CV data: {str(e)}")
            # Don't fail the application if candidate save fails
    
    # Create application (exclude analyzed_cv_data from the dict as it's not a model field)
    app_data = application.dict(exclude={"analyzed_cv_data"})
    app_data["candidate_id"] = candidate_id  # Add the candidate_id reference
    
    db_app = JobApplication(**app_data)
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity on the job
    log_activity(db, job.id, None, "NEW_APPLICATION", f"New application from {db_app.candidate_name}")
    
    # Update daily stats (simple increment for today)
    update_daily_stats(db, job.id, application=True)
    
    return db_app

@router.put("/applications/{application_id}", response_model=JobApplicationSchema)
def update_application_status(
    application_id: int,
    app_update: JobApplicationUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    db_app = db.query(JobApplication).filter(JobApplication.id == application_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
        
    old_status = db_app.status
    
    update_data = app_update.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_app, key, value)
        
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    if "status" in update_data and old_status != db_app.status:
        log_activity(db, db_app.job_posting_id, current_user.id, "STATUS_CHANGE", f"Candidate {db_app.candidate_name} moved to {db_app.status}")
        
    return db_app

# --- Notes ---

@router.post("/applications/{application_id}/notes", response_model=JobApplicationNoteSchema)
def add_application_note(
    application_id: int,
    note: JobApplicationNoteCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    db_app = db.query(JobApplication).filter(JobApplication.id == application_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
        
    db_note = JobApplicationNote(
        application_id=application_id,
        author_id=current_user.id,
        note=note.note
    )
    db.add(db_note)
    db.commit()
    db.refresh(db_note)
    return db_note

@router.get("/applications/{application_id}/notes", response_model=List[JobApplicationNoteSchema])
def get_application_notes(
    application_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    return db.query(JobApplicationNote).filter(JobApplicationNote.application_id == application_id).all()

@router.post("/jobs/{job_id}/notes", response_model=JobPostingNoteSchema)
def add_job_note(
    job_id: int,
    note: JobPostingNoteCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    if not db.query(JobPosting).filter(JobPosting.id == job_id).first():
        raise HTTPException(status_code=404, detail="Job posting not found")
        
    db_note = JobPostingNote(
        job_posting_id=job_id,
        author_id=current_user.id,
        note=note.note
    )
    db.add(db_note)
    db.commit()
    db.refresh(db_note)
    return db_note

@router.get("/jobs/{job_id}/notes", response_model=List[JobPostingNoteSchema])
def get_job_notes(
    job_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    return db.query(JobPostingNote).filter(JobPostingNote.job_posting_id == job_id).all()

# --- Analytics & Activity ---

@router.get("/jobs/{job_id}/stats", response_model=List[JobPostingDailyStatsSchema])
def get_job_stats(
    job_id: int,
    days: int = 30,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    # Return last N days of stats
    return db.query(JobPostingDailyStats)\
        .filter(JobPostingDailyStats.job_posting_id == job_id)\
        .order_by(JobPostingDailyStats.date.desc())\
        .limit(days)\
        .all()

# --- Pipeline Endpoints ---

@router.get("/jobs/{job_id}/pipeline/{stage}", response_model=List[JobApplicationSchema])
def get_applications_by_stage(
    job_id: int,
    stage: str,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Get all applications for a specific job at a specific pipeline stage"""
    # Validate stage
    valid_stages = ["applied", "ai_review", "exam", "ai_interview", "cv_verification", "proposal"]
    if stage not in valid_stages:
        raise HTTPException(status_code=400, detail=f"Invalid stage. Must be one of: {', '.join(valid_stages)}")
    
    # Check if job exists
    if not db.query(JobPosting).filter(JobPosting.id == job_id).first():
        raise HTTPException(status_code=404, detail="Job posting not found")
    
    applications = db.query(JobApplication).filter(
        JobApplication.job_posting_id == job_id,
        JobApplication.pipeline_stage == stage
    ).all()
    
    return applications

@router.post("/applications/{app_id}/pipeline/advance", response_model=JobApplicationSchema)
def advance_application(
    app_id: int,
    stage_update: PipelineStageUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Move application to the next pipeline stage"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Validate stage progression
    stage_order = ["applied", "ai_review", "exam", "ai_interview", "cv_verification", "proposal"]
    if stage_update.stage not in stage_order:
        raise HTTPException(status_code=400, detail="Invalid pipeline stage")
    
    # Update pipeline stage
    db_app.pipeline_stage = stage_update.stage
    db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    # Initialize default documents_required when entering cv_verification stage
    if stage_update.stage == "cv_verification" and not db_app.documents_required:
        db_app.documents_required = [
            {"document_type": "id_card", "title": "Government-issued ID", "description": "Passport, Driver's License, or National ID", "required": True, "submitted": False},
            {"document_type": "diploma", "title": "Educational Diploma", "description": "Degree certificate or diploma", "required": True, "submitted": False},
            {"document_type": "certificate", "title": "Professional Certificates", "description": "Relevant certifications", "required": False, "submitted": False},
            {"document_type": "reference", "title": "Professional References", "description": "2-3 professional references", "required": True, "submitted": False},
        ]
        if db_app.documents_submitted is None:
            db_app.documents_submitted = []
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db, 
        db_app.job_posting_id, 
        current_user.id, 
        "PIPELINE_STAGE_CHANGE",
        f"Candidate {db_app.candidate_name} moved to {stage_update.stage}" + 
        (f": {stage_update.notes}" if stage_update.notes else "")
    )
    
    return db_app

@router.post("/applications/{app_id}/ai-review", response_model=JobApplicationSchema)
async def update_ai_review(
    app_id: int,
    review_result: AIReviewResult,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Update AI review results for an application"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Update AI review fields
    db_app.ai_review_result = review_result.dict()
    db_app.ai_review_score = review_result.score
    db_app.pipeline_stage = "ai_review"
    db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db,
        db_app.job_posting_id,
        current_user.id,
        "AI_REVIEW_COMPLETE",
        f"AI review completed for {db_app.candidate_name} with score {review_result.score}"
    )
    
    return db_app

@router.post("/applications/{app_id}/trigger-ai-review", response_model=JobApplicationSchema)
async def trigger_ai_review(
    app_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user),
    token: str = Depends(oauth2_scheme)
):
    """Trigger AI review for an application by calling the AI service"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Get job posting details
    job = db.query(JobPosting).filter(JobPosting.id == db_app.job_posting_id).first()
    if not job:
        raise HTTPException(status_code=404, detail="Job posting not found")
    
    try:
        # Call AI service for CV review
        # Extract candidate data from tables or raw text
        cv_text = ""
        
        # 1. Try to fetch structured candidate data from DB
        print(f"db_app.candidate_id: {db_app}")
        if db_app.candidate_id:
            candidate = db.query(Candidate).filter(Candidate.candidate_id == db_app.candidate_id).first()
            print(f"Candidate: {candidate}")
            if candidate:
                lines = []
                lines.append(f"Candidate Name: {candidate.full_name}")
                lines.append(f"Current Position: {candidate.current_position or 'N/A'}")
                lines.append(f"Summary: {candidate.personal_info.professional_summary if candidate.personal_info else 'N/A'}")
                print(f"Candidate Summary: {candidate.personal_info.professional_summary if candidate.personal_info else 'N/A'}")
                
                lines.append("\nWork Experience:")
                if candidate.work_experiences:
                    for exp in candidate.work_experiences:
                        lines.append(f"- {exp.job_title} at {exp.company} ({exp.start_date} - {exp.end_date or 'Present'})")
                        if exp.description:
                            lines.append(f"  Description: {exp.description}")
                        for resp in exp.responsibilities:
                            lines.append(f"  * {resp.responsibility}")
                else:
                    lines.append("No work experience listed.")

                lines.append("\nEducation:")
                if candidate.education:
                    for edu in candidate.education:
                        lines.append(f"- {edu.degree} in {edu.field_of_study} at {edu.institution} ({edu.start_date} - {edu.end_date or 'Present'})")
                else:
                     lines.append("No education listed.")

                lines.append("\nTechnical Skills:")
                if candidate.technical_skills:
                    skills = [f"{skill.skill_name} ({skill.proficiency_level or 'N/A'})" for skill in candidate.technical_skills]
                    lines.append(", ".join(skills))
                else:
                    lines.append("No technical skills listed.")

                lines.append("\nSoft Skills:")
                if candidate.soft_skills:
                    soft_skills = [skill.skill_name for skill in candidate.soft_skills]
                    lines.append(", ".join(soft_skills))
                
                lines.append("\nCertifications:")
                if candidate.certifications:
                    certs = [f"{cert.certification_name} ({cert.issuing_organization})" for cert in candidate.certifications]
                    lines.append(", ".join(certs))

                lines.append("\nProjects:")
                if candidate.projects:
                    for proj in candidate.projects:
                        lines.append(f"- {proj.project_name}: {proj.description or 'No description'}")

                candidate_data_text = "\n".join(lines)
                
                # Check for missing data and augment with raw data if needed
                # If core sections are empty, check raw data
                has_experience = bool(candidate.work_experiences)
                has_education = bool(candidate.education)
                has_skills = bool(candidate.technical_skills)
                
                if not (has_experience and has_education and has_skills):
                     # Fetch raw data
                     raw_entry = db.query(CandidateRawData).filter(CandidateRawData.candidate_id == candidate.candidate_id).first()
                     if raw_entry and raw_entry.raw_structured_data:
                         candidate_data_text += "\n\n--- Raw Data Supplement ---\n"
                         candidate_data_text += json.dumps(raw_entry.raw_structured_data, indent=2, default=str)
                
                cv_text = candidate_data_text
        
        # 2. Fallback to file extraction if no structured data found
        if not cv_text and db_app.resume_url and "/files/" in db_app.resume_url:
            filename = db_app.resume_url.split("/files/")[-1]
            
            # Fetch text from io-service
            io_service_url = f"http://io-service:8000/api/io/cv-application/files/{filename}/text"
            try:
                async with httpx.AsyncClient() as client:
                    resp = await client.get(io_service_url, timeout=30.0)
                    if resp.status_code == 200:
                        cv_text = resp.json().get("text", "")
                    else:
                        logger.warning(f"Failed to fetch CV text: {resp.status_code}")
                        cv_text = f"Could not extract text from resume. Candidate: {db_app.candidate_name}"
            except Exception as e:
                logger.error(f"Error fetching CV text: {e}")
                cv_text = f"Error extracting text. Candidate: {db_app.candidate_name}"
        
        if not cv_text:
             cv_text = f"Resume content for {db_app.candidate_name} (Text extraction failed or no resume provided)"
        
        # Log the source of data for debugging (optional)
        logger.info(f"AI Review using data source: {'Structured DB' if db_app.candidate_id and cv_text != '' else 'File Extraction'}")

        async with httpx.AsyncClient() as client:
            response = await client.post(
                "http://ai-service:8000/api/ai/generate/cv-review", # Role uygunluk test edilecek.
                json={
                    "cv_text": cv_text,
                    "job_requirements": job.requirements or [],
                    "job_description": job.description or "",
                    "candidate_name": db_app.candidate_name
                },
                headers={"Authorization": f"Bearer {token}"},
                timeout=60.0
            )
            
            if response.status_code != 200:
                logger.error(f"AI service request failed: {response.status_code} - {response.text}")
                raise HTTPException(status_code=500, detail=f"AI service request failed: {response.text}")
            
            ai_result = response.json()
            logger.info(f"AI Result received: {ai_result}")
            
            # Parse AI result - the AI service now returns parsed JSON in "result" field
            try:
                result_content = ai_result.get("result")
                
                if result_content is None:
                    raise ValueError("AI service returned empty result")
                
                # The AI service now parses JSON and returns it as a dict
                if isinstance(result_content, dict):
                    # Already parsed JSON from AI service
                    result_data = result_content
                    logger.info(f"AI review result (dict): score={result_data.get('score')}")
                elif isinstance(result_content, str):
                    # Fallback: try to parse if AI service returned string (shouldn't happen with updated AI service)
                    import re
                    json_match = re.search(r'\{[\s\S]*\}', result_content)
                    if json_match:
                        result_data = json.loads(json_match.group())
                        logger.info(f"AI review result (parsed from string): score={result_data.get('score')}")
                    else:
                        logger.error(f"Failed to parse AI response as JSON: {result_content[:500]}")
                        raise ValueError(f"AI response is not valid JSON: {result_content[:200]}")
                else:
                    raise ValueError(f"Unexpected result type: {type(result_content)}")
                
                # Update application with AI review
                db_app.ai_review_result = result_data
                db_app.ai_review_score = result_data.get("score", 0)
                db_app.pipeline_stage = "ai_review"
                db_app.pipeline_stage_updated_at = datetime.utcnow()
                
                db.add(db_app)
                db.commit()
                db.refresh(db_app)
                
                # Log activity
                log_activity(
                    db,
                    db_app.job_posting_id,
                    current_user.id,
                    "AI_REVIEW_TRIGGERED",
                    f"AI review triggered for {db_app.candidate_name}"
                )
                
                return db_app
                
            except json.JSONDecodeError as e:
                logger.error(f"JSON decode error: {str(e)}")
                raise HTTPException(status_code=500, detail="Failed to parse AI response")
            except ValueError as e:
                logger.error(f"Value error in AI response: {str(e)}")
                raise HTTPException(status_code=500, detail=str(e))
                
    except httpx.RequestError as e:
        raise HTTPException(status_code=500, detail=f"AI service connection failed: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"AI review failed: {str(e)}")

@router.post("/applications/{app_id}/assign-exam", response_model=JobApplicationSchema)
def assign_exam(
    app_id: int,
    exam_data: ExamAssignment,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Assign an exam to an application"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Update exam fields
    db_app.exam_assigned = True
    db_app.exam_platform_id = exam_data.exam_id
    db_app.pipeline_stage = "exam"
    db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db,
        db_app.job_posting_id,
        current_user.id,
        "EXAM_ASSIGNED",
        f"Exam assigned to {db_app.candidate_name} on platform {exam_data.platform}"
    )
    
    return db_app

@router.post("/applications/{app_id}/exam-results", response_model=JobApplicationSchema)
def update_exam_results(
    app_id: int,
    exam_result: ExamResult,
    db: Session = Depends(get_db)
):
    """Update exam results (webhook endpoint from external platform)"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Update exam results
    db_app.exam_score = exam_result.score
    db_app.exam_completed_at = exam_result.completed_at
    
    # Auto-advance to next stage if passed
    if exam_result.passed:
        db_app.pipeline_stage = "ai_interview"
        db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db,
        db_app.job_posting_id,
        None,
        "EXAM_COMPLETED",
        f"Exam completed by {db_app.candidate_name} with score {exam_result.score}"
    )
    
    return db_app

@router.post("/applications/{app_id}/schedule-interview", response_model=JobApplicationSchema)
def schedule_interview(
    app_id: int,
    interview_data: AIInterviewSchedule,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Schedule an AI interview for an application"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Update interview fields
    db_app.ai_interview_type = interview_data.interview_type
    db_app.ai_interview_scheduled_at = interview_data.scheduled_at
    db_app.pipeline_stage = "ai_interview"
    db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db,
        db_app.job_posting_id,
        current_user.id,
        "INTERVIEW_SCHEDULED",
        f"AI {interview_data.interview_type} interview scheduled for {db_app.candidate_name}"
    )
    
    return db_app

@router.post("/applications/{app_id}/simulate-interview-complete", response_model=JobApplicationSchema)
def simulate_interview_complete(
    app_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Simulate completing an AI interview (for development/testing)"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    if not db_app.ai_interview_scheduled_at:
        raise HTTPException(status_code=400, detail="Interview must be scheduled first")
    
    # Mark interview as completed
    db_app.ai_interview_completed_at = datetime.utcnow()
    db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db,
        db_app.job_posting_id,
        current_user.id,
        "INTERVIEW_COMPLETED",
        f"AI interview completed (simulated) for {db_app.candidate_name}"
    )
    
    return db_app


@router.post("/applications/{app_id}/documents", response_model=JobApplicationSchema)
def update_documents(
    app_id: int,
    document_update: DocumentUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Update document requirements and submissions for CV verification stage"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Convert documents to dict for JSON storage
    documents_data = [doc.dict() for doc in document_update.documents]
    
    # Separate required and submitted documents
    db_app.documents_required = [doc for doc in documents_data if doc.get('required')]
    db_app.documents_submitted = [doc for doc in documents_data if doc.get('submitted')]
    
    # Check if all required documents are submitted
    all_submitted = all(
        doc.get('submitted', False) 
        for doc in documents_data 
        if doc.get('required', False)
    )
    
    # Auto-advance if all documents are submitted and approved
    if all_submitted:
        db_app.pipeline_stage = "proposal"
        db_app.pipeline_stage_updated_at = datetime.utcnow()
    else:
        db_app.pipeline_stage = "cv_verification"
        db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db,
        db_app.job_posting_id,
        current_user.id,
        "DOCUMENTS_UPDATED",
        f"Document verification updated for {db_app.candidate_name}"
    )
    
    return db_app

@router.post("/applications/{app_id}/send-proposal", response_model=JobApplicationSchema)
def send_proposal(
    app_id: int,
    proposal_data: ProposalData,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """Send job proposal to candidate"""
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    # Update proposal fields
    db_app.proposal_sent_at = datetime.utcnow()
    db_app.pipeline_stage = "proposal"
    db_app.pipeline_stage_updated_at = datetime.utcnow()
    
    db.add(db_app)
    db.commit()
    db.refresh(db_app)
    
    # Log activity
    log_activity(
        db,
        db_app.job_posting_id,
        current_user.id,
        "PROPOSAL_SENT",
        f"Job proposal sent to {db_app.candidate_name} for {proposal_data.position}"
    )
    
    return db_app
# --- Exam System Integration ---

# Environment configuration for exam system
# Use host.docker.internal to reach services running on host from Docker container
EXAM_SYSTEM_URL = os.getenv("EXAM_SYSTEM_URL", "http://host.docker.internal:2000")
EXAM_WEBHOOK_SECRET = os.getenv("EXAM_WEBHOOK_SECRET", "your-webhook-secret")
EXAM_SYSTEM_API_KEY = os.getenv("EXAM_SYSTEM_API_KEY", "your-api-key")

@router.post("/webhooks/exam-events")
async def handle_exam_webhook(
    event: ExamWebhookEvent,
    db: Session = Depends(get_db)
):
    """
    Receive exam status updates from the exam system.
    This is called by the exam system when:
    - Candidate starts the exam (exam_started)
    - Candidate submits the exam (exam_submitted)
    - Exam is graded/finalized (exam_graded)
    """
    logger.info(f"Received exam webhook: {event.event} for application {event.externalAppId}")
    
    try:
        # Find the job application by ID
        app_id = int(event.externalAppId)
        db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
        
        if not db_app:
            logger.error(f"Application not found: {event.externalAppId}")
            raise HTTPException(status_code=404, detail="Application not found")
        
        # Handle different event types
        if event.event == "exam_started":
            db_app.exam_started_at = datetime.fromisoformat(event.data.startedAt.replace('Z', '+00:00')) if event.data.startedAt else datetime.utcnow()
            
            log_activity(
                db,
                db_app.job_posting_id,
                None,
                "EXAM_STARTED",
                f"Candidate {db_app.candidate_name} started the exam"
            )
            
        elif event.event == "exam_submitted":
            db_app.exam_completed_at = datetime.fromisoformat(event.data.submittedAt.replace('Z', '+00:00')) if event.data.submittedAt else datetime.utcnow()
            
            log_activity(
                db,
                db_app.job_posting_id,
                None,
                "EXAM_SUBMITTED",
                f"Candidate {db_app.candidate_name} submitted the exam" + 
                (f" (timed out)" if event.data.timedOut else "") +
                f" - Answered {event.data.answeredQuestions}/{event.data.totalQuestions} questions"
            )
            
        elif event.event == "exam_graded":
            db_app.exam_score = int(event.data.totalScore) if event.data.totalScore else None
            db_app.exam_finalized_score = event.data.totalScore
            
            # Determine if passed (e.g., >= 60%)
            passed = False
            if event.data.percentage and event.data.percentage >= 60:
                passed = True
                # Auto-advance to next pipeline stage
                db_app.pipeline_stage = "ai_interview"
                db_app.pipeline_stage_updated_at = datetime.utcnow()
            
            log_activity(
                db,
                db_app.job_posting_id,
                None,
                "EXAM_GRADED",
                f"Exam graded for {db_app.candidate_name}: {event.data.totalScore}/{event.data.maxScore} ({event.data.percentage}%)" +
                (f" - Advanced to AI Interview" if passed else " - Did not meet passing threshold")
            )
        
        db.add(db_app)
        db.commit()
        db.refresh(db_app)
        
        return {"success": True, "message": f"Processed {event.event} event"}
        
    except ValueError as e:
        logger.error(f"Invalid application ID format: {event.externalAppId}")
        raise HTTPException(status_code=400, detail="Invalid application ID format")
    except Exception as e:
        logger.error(f"Error processing exam webhook: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to process webhook: {str(e)}")

@router.post("/applications/{app_id}/assign-exam-v2", response_model=JobApplicationSchema)
async def assign_exam_v2(
    app_id: int,
    exam_data: ExamAssignment,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    """
    Assign an exam to an application by creating it in the exam system.
    This enhanced version:
    1. Calls the exam system API to create a CandidateExam
    2. Receives the access code
    3. Stores the access code in the JobApplication
    """
    db_app = db.query(JobApplication).filter(JobApplication.id == app_id).first()
    if not db_app:
        raise HTTPException(status_code=404, detail="Application not found")
    
    try:
        # Prepare the request to exam system
        webhook_url = f"{os.getenv('BASE_SERVICE_URL', 'http://localhost:80')}/api/base/recruitment/webhooks/exam-events"
        
        exam_request = CreateCandidateExamRequest(
            examId=exam_data.exam_id,
            candidateName=db_app.candidate_name,
            candidateEmail=db_app.email,
            externalAppId=str(app_id),
            webhookUrl=webhook_url,
            webhookSecret=EXAM_WEBHOOK_SECRET,
            expiresAt=exam_data.due_date.isoformat() if exam_data.due_date else (datetime.utcnow().replace(hour=23, minute=59, second=59) + timedelta(days=7)).isoformat()
        )
        
        # Call exam system API
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{EXAM_SYSTEM_URL}/api/candidate-exams",
                json=exam_request.dict(),
                headers={
                    "Content-Type": "application/json",
                    "x-api-key": EXAM_SYSTEM_API_KEY
                },
                timeout=30.0
            )
            
            if response.status_code != 201 and response.status_code != 200:
                logger.error(f"Exam system API error: {response.status_code} - {response.text}")
                raise HTTPException(
                    status_code=500, 
                    detail=f"Failed to create exam in exam system: {response.text}"
                )
            
            result = response.json()
            
            if not result.get("success"):
                raise HTTPException(status_code=500, detail="Exam system returned failure")
            
            candidate_exam = result.get("candidateExam", {})
            access_code = candidate_exam.get("accessCode")
            
            if not access_code:
                raise HTTPException(status_code=500, detail="No access code returned from exam system")
        
        # Update application with exam details
        db_app.exam_assigned = True
        db_app.exam_platform_id = candidate_exam.get("id")
        db_app.exam_access_code = access_code
        db_app.pipeline_stage = "exam"
        db_app.pipeline_stage_updated_at = datetime.utcnow()
        
        db.add(db_app)
        db.commit()
        db.refresh(db_app)
        
        # Log activity
        log_activity(
            db,
            db_app.job_posting_id,
            current_user.id,
            "EXAM_ASSIGNED",
            f"Exam assigned to {db_app.candidate_name} - Access code: {access_code}"
        )
        
        logger.info(f"Successfully assigned exam to application {app_id} with access code {access_code}")
        
        return db_app
        
    except httpx.RequestError as e:
        logger.error(f"Failed to connect to exam system: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to connect to exam system: {str(e)}")
    except Exception as e:
        logger.error(f"Error assigning exam: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to assign exam: {str(e)}")

# --- Helpers ---

def log_activity(db: Session, job_id: int, actor_id: Optional[int], action_type: str, details: str):
    activity = JobPostingActivity(
        job_posting_id=job_id,
        actor_id=actor_id,
        action_type=action_type,
        details=details
    )
    db.add(activity)
    db.commit()

def update_daily_stats(db: Session, job_id: int, application: bool = False, view: bool = False):
    today = date.today()
    stats = db.query(JobPostingDailyStats).filter(
        JobPostingDailyStats.job_posting_id == job_id,
        JobPostingDailyStats.date == today
    ).first()
    
    if not stats:
        stats = JobPostingDailyStats(
            job_posting_id=job_id,
            date=today,
            views_count=0,
            applications_count=0
        )
        db.add(stats)
    
    if application:
        stats.applications_count += 1
    if view:
        stats.views_count += 1
        
    db.commit()


