from fastapi import APIRouter, HTTPException, status, Depends
from typing import Dict, Any
from ..schemas.ai import AIRequest, AIResponse
from ..services.ai_worker import ai_worker
from ..dependencies import RoleChecker
from ..models.role import UserRole

router = APIRouter(
    prefix="/generate",
    tags=["ai"]
)

allow_any_authenticated_user = Depends(RoleChecker([UserRole.ADMIN, UserRole.USER]))

@router.post("/", response_model=AIResponse, dependencies=[allow_any_authenticated_user])
async def generate_content(request: AIRequest):
    try:
        content = await ai_worker.process_task(
            task_type=request.task_type,
            prompt=request.prompt,
            **(request.parameters or {})
        )
        return AIResponse(content=content)
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=str(e)
        )

@router.post("/cv-review", dependencies=[allow_any_authenticated_user])
async def review_cv_for_job(
    cv_text: str,
    job_requirements: list[str],
    job_description: str,
    candidate_name: str
):
    """
    Analyze a candidate's CV against job requirements using AI.
    Returns a detailed review with score, explanation, strengths, and concerns.
    """
    try:
        # Construct the prompt for AI review
        prompt = f"""
        You are an expert HR professional and recruiter. Analyze the following candidate's CV against the job requirements.
        
        Candidate: {candidate_name}
        
        Job Description:
        {job_description}
        
        Job Requirements:
        {chr(10).join(f"- {req}" for req in job_requirements)}
        
        Candidate CV:
        {cv_text}
        
        Provide a detailed analysis in the following JSON format:
        {{
            "score": <0-100 integer representing overall match>,
            "explanation": "<brief explanation of the assessment>",
            "suitable": <true/false>,
            "strengths": ["<strength 1>", "<strength 2>", ...],
            "concerns": ["<concern 1>", "<concern 2>", ...],
            "matched_requirements": ["<requirement 1>", "<requirement 2>", ...],
            "missing_requirements": ["<requirement 1>", "<requirement 2>", ...]
        }}
        
        Be objective, thorough, and provide actionable insights.
        """
        
        # Process the AI review
        content = await ai_worker.process_task(
            task_type="text_generation",
            prompt=prompt,
            max_output_tokens=2000
        )
        
        return {"result": content}
        
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"CV review failed: {str(e)}"
        )

