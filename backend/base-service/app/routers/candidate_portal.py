from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List, Optional
from datetime import datetime

from ..database import get_db
from ..models.candidate import PortalUser, PortalDocument
from ..models.recruitment import JobApplication, JobPosting
from ..schemas.candidate import (
    CandidateResponse, CandidateProfileUpdate,
    CandidateApplicationSummary, CandidateApplicationDetail,
    DocumentResponse, DocumentCreate, DocumentRequirementStatus,
    InterviewInfo, ExamInfo, ProposalInfo, ProposalResponse
)
from ..services.candidate_service import CandidateService
from .candidate_auth import get_current_active_candidate

router = APIRouter(
    prefix="/candidate",
    tags=["Candidate Portal"],
)

# Default document requirements for CV verification stage
DEFAULT_DOCUMENT_REQUIREMENTS = [
    {"document_type": "id_card", "title": "Government-issued ID", "description": "Passport, Driver's License, or National ID", "required": True},
    {"document_type": "diploma", "title": "Educational Diploma", "description": "Degree certificate or diploma", "required": True},
    {"document_type": "certificate", "title": "Professional Certificates", "description": "Relevant certifications", "required": False},
    {"document_type": "reference", "title": "Professional References", "description": "2-3 professional references", "required": True},
]


def build_application_summary(app: JobApplication, job: JobPosting, documents: List[PortalDocument] = None) -> CandidateApplicationSummary:
    """Build application summary from database objects"""
    documents = documents or []
    
    # Count document statuses
    docs_pending = len([d for d in documents if d.status == "pending"])
    docs_approved = len([d for d in documents if d.status == "approved"])
    
    return CandidateApplicationSummary(
        id=app.id,
        job_title=job.title,
        company_name="HRiQ Inc.",
        department=job.department,
        location=job.location,
        pipeline_stage=app.pipeline_stage,
        applied_at=app.applied_at,
        status=app.status,
        exam_assigned=app.exam_assigned or False,
        exam_completed=app.exam_completed_at is not None,
        exam_score=app.exam_score,
        interview_scheduled=app.ai_interview_scheduled_at is not None,
        interview_completed=app.ai_interview_completed_at is not None,
        interview_type=app.ai_interview_type,
        interview_scheduled_at=app.ai_interview_scheduled_at,
        documents_pending=docs_pending,
        documents_approved=docs_approved,
        proposal_sent=app.proposal_sent_at is not None,
        proposal_accepted=app.proposal_accepted
    )


@router.get("/profile", response_model=CandidateResponse)
def get_profile(
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Get current candidate's profile"""
    return current_candidate


@router.put("/profile", response_model=CandidateResponse)
def update_profile(
    data: CandidateProfileUpdate,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Update candidate profile"""
    service = CandidateService(db)
    return service.update_profile(current_candidate.id, data)


@router.get("/applications", response_model=List[CandidateApplicationSummary])
def get_applications(
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Get all applications for the current candidate"""
    service = CandidateService(db)
    applications = service.get_applications(current_candidate.email)
    
    result = []
    for app in applications:
        job = db.query(JobPosting).filter(JobPosting.id == app.job_posting_id).first()
        if job:
            documents = service.get_documents(current_candidate.id, app.id)
            result.append(build_application_summary(app, job, documents))
    
    return result


@router.get("/applications/{app_id}", response_model=CandidateApplicationDetail)
def get_application_detail(
    app_id: int,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Get detailed view of a specific application"""
    service = CandidateService(db)
    
    # Verify ownership
    app = service.get_application(current_candidate.email, app_id)
    if not app:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Application not found"
        )
    
    job = db.query(JobPosting).filter(JobPosting.id == app.job_posting_id).first()
    if not job:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Job posting not found"
        )
    
    # Get documents
    documents = service.get_documents(current_candidate.id, app_id)
    
    # Build document requirements with status
    doc_requirements = []
    for req in DEFAULT_DOCUMENT_REQUIREMENTS:
        # Find if document of this type was uploaded
        uploaded_doc = next((d for d in documents if d.document_type == req["document_type"]), None)
        
        doc_requirements.append(DocumentRequirementStatus(
            document_type=req["document_type"],
            title=req["title"],
            description=req.get("description"),
            required=req["required"],
            submitted=uploaded_doc is not None,
            status=uploaded_doc.status if uploaded_doc else None,
            document=DocumentResponse.model_validate(uploaded_doc) if uploaded_doc else None
        ))
    
    # Build summary first
    summary = build_application_summary(app, job, documents)
    
    return CandidateApplicationDetail(
        **summary.model_dump(),
        job_description=job.description,
        exam_access_code=app.exam_access_code,
        exam_platform_id=app.exam_platform_id,
        documents=[DocumentResponse.model_validate(d) for d in documents],
        document_requirements=doc_requirements
    )


@router.get("/applications/{app_id}/documents", response_model=List[DocumentRequirementStatus])
def get_document_requirements(
    app_id: int,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Get document requirements and their status for an application"""
    service = CandidateService(db)
    
    # Get the application
    application = service.get_application(current_candidate.email, app_id)
    if not application:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Application not found"
        )
    
    # Get uploaded documents from PortalDocument table
    documents = service.get_documents(current_candidate.id, app_id)
    
    # Use application-specific requirements if set, otherwise use defaults
    requirements = application.documents_required if application.documents_required else DEFAULT_DOCUMENT_REQUIREMENTS
    
    # Build requirements list with status
    result = []
    for req in requirements:
        uploaded_doc = next((d for d in documents if d.document_type == req.get("document_type")), None)
        
        result.append(DocumentRequirementStatus(
            document_type=req.get("document_type"),
            title=req.get("title"),
            description=req.get("description"),
            required=req.get("required", True),
            submitted=uploaded_doc is not None,
            status=uploaded_doc.status if uploaded_doc else None,
            document=DocumentResponse.model_validate(uploaded_doc) if uploaded_doc else None
        ))
    
    return result


@router.post("/applications/{app_id}/documents", response_model=DocumentResponse, status_code=status.HTTP_201_CREATED)
def upload_document(
    app_id: int,
    document: DocumentCreate,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """
    Create a document record for an application.
    
    Note: The actual file upload should be done to io-service first,
    then this endpoint is called with the file_url.
    """
    service = CandidateService(db)
    
    # Verify ownership
    if not service.verify_application_ownership(current_candidate.email, app_id):
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Application not found"
        )
    
    # Get the application to update documents_submitted
    application = service.get_application(current_candidate.email, app_id)
    
    # Check if document of this type already exists
    existing_docs = service.get_documents(current_candidate.id, app_id)
    existing = next((d for d in existing_docs if d.document_type == document.document_type), None)
    
    portal_doc = None
    if existing:
        # Update existing document
        existing.file_url = document.file_url
        existing.file_name = document.file_name
        existing.file_size = document.file_size
        existing.mime_type = document.mime_type
        existing.title = document.title
        existing.status = "pending"  # Reset status on re-upload
        existing.uploaded_at = datetime.utcnow()
        existing.reviewed_at = None
        existing.reviewer_notes = None
        
        db.commit()
        db.refresh(existing)
        portal_doc = existing
    else:
        # Create new document record
        document.application_id = app_id
        portal_doc = service.create_document(current_candidate.id, document)
    
    # Sync to JobApplication.documents_submitted for HR side visibility
    _sync_document_to_application(db, application, portal_doc)
    
    return portal_doc


def _sync_document_to_application(db: Session, application: JobApplication, portal_doc):
    """Sync uploaded document to JobApplication.documents_submitted field"""
    if application.documents_submitted is None:
        application.documents_submitted = []
    
    # Create document entry for the application's documents_submitted list
    doc_entry = {
        "document_type": portal_doc.document_type,
        "title": portal_doc.title or portal_doc.document_type,
        "file_url": portal_doc.file_url,
        "submitted": True,
        "submitted_at": portal_doc.uploaded_at.isoformat() if portal_doc.uploaded_at else datetime.utcnow().isoformat(),
        "status": portal_doc.status
    }
    
    # Update existing or append new
    existing_idx = next(
        (i for i, d in enumerate(application.documents_submitted) 
         if d.get("document_type") == portal_doc.document_type),
        None
    )
    
    if existing_idx is not None:
        application.documents_submitted[existing_idx] = doc_entry
    else:
        application.documents_submitted.append(doc_entry)
    
    # Mark the field as modified for SQLAlchemy to detect changes to JSON
    from sqlalchemy.orm.attributes import flag_modified
    flag_modified(application, "documents_submitted")
    
    db.commit()
    db.refresh(application)


@router.get("/applications/{app_id}/interview", response_model=InterviewInfo)
def get_interview_info(
    app_id: int,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Get interview information for an application"""
    service = CandidateService(db)
    
    app = service.get_application(current_candidate.email, app_id)
    if not app:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Application not found"
        )
    
    return InterviewInfo(
        interview_type=app.ai_interview_type,
        scheduled_at=app.ai_interview_scheduled_at,
        completed_at=app.ai_interview_completed_at,
        meeting_url=f"/portal/applications/{app_id}/interview/join" if app.ai_interview_scheduled_at else None,
        instructions="Please join the interview at the scheduled time. Make sure you have a stable internet connection and are in a quiet environment."
    )


@router.get("/applications/{app_id}/exam", response_model=ExamInfo)
def get_exam_info(
    app_id: int,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Get exam information for an application"""
    service = CandidateService(db)
    
    app = service.get_application(current_candidate.email, app_id)
    if not app:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Application not found"
        )
    
    return ExamInfo(
        assigned=app.exam_assigned or False,
        platform_id=app.exam_platform_id,
        access_code=app.exam_access_code,
        exam_url=f"/exam/{app.exam_access_code}" if app.exam_access_code else None,
        started_at=app.exam_started_at,
        completed_at=app.exam_completed_at,
        score=app.exam_score,
        instructions="Use the access code provided to start your exam. You will have a limited time to complete all questions."
    )


@router.get("/applications/{app_id}/proposal", response_model=ProposalInfo)
def get_proposal_info(
    app_id: int,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Get job proposal information for an application"""
    service = CandidateService(db)
    
    app = service.get_application(current_candidate.email, app_id)
    if not app:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Application not found"
        )
    
    job = db.query(JobPosting).filter(JobPosting.id == app.job_posting_id).first()
    
    return ProposalInfo(
        sent_at=app.proposal_sent_at,
        accepted=app.proposal_accepted,
        position=job.title if job else None,
        salary_offer=job.salary_range_max if job else None,
        salary_currency=job.salary_currency if job else "USD",
        benefits=job.benefits if job else [],
        additional_notes="We're excited to extend this offer to you! Please review the details and let us know your decision."
    )


@router.post("/applications/{app_id}/proposal/respond", status_code=status.HTTP_200_OK)
def respond_to_proposal(
    app_id: int,
    response: ProposalResponse,
    db: Session = Depends(get_db),
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """Accept or reject a job proposal"""
    service = CandidateService(db)
    
    app = service.get_application(current_candidate.email, app_id)
    if not app:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Application not found"
        )
    
    if not app.proposal_sent_at:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="No proposal has been sent for this application"
        )
    
    if app.proposal_accepted is not None:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Proposal has already been responded to"
        )
    
    # Update proposal response
    app.proposal_accepted = response.accepted
    
    # Update status based on response
    if response.accepted:
        app.status = "Hired"
    else:
        app.status = "Declined"
    
    db.commit()
    
    return {
        "message": "Proposal accepted! Welcome to the team!" if response.accepted else "We respect your decision. Thank you for considering us.",
        "accepted": response.accepted
    }

