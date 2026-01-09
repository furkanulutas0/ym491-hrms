from fastapi import APIRouter, HTTPException, status, Depends
from typing import Dict, Any, List
import httpx
from pydantic import BaseModel
from ..schemas.ai import AIRequest, AIResponse
from ..services.ai_worker import ai_worker
from ..dependencies import RoleChecker
from ..models.role import UserRole
from ..core.config import settings

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

class JobAssistRequest(BaseModel):
    title: str
    department: str | None = None
    location: str | None = None
    work_type: str | None = None
    description: str | None = None
    responsibilities: List[str] | None = None
    requirements: List[str] | None = None
    benefits: List[str] | None = None

@router.post("/job-assist", dependencies=[allow_any_authenticated_user])
async def assist_job_posting(request: JobAssistRequest):
    """
    Enhance job posting details using Gemini.
    """
    try:
        # Construct the prompt
        prompt = f"""
        You are an expert HR professional and recruiter. Improve and complete the following job posting details.
        
        Current Details (JSON):
        {request.json()}
        
        Instructions:
        1. Analyze the provided details.
        2. Generate professional, engaging, and clear content for all fields.
        3. If a field is empty, generate suitable content based on the Job Title and Department.
        4. If a field has content, improve it for better clarity and impact.
        5. For 'responsibilities', 'requirements', and 'benefits', provide 5-7 distinct, bullet-point style items as a list of strings.
        6. Ensure 'salary_range_min' and 'salary_range_max' are realistic if not provided (but prefer keeping them null if unsure).
        
        Return ONLY a valid JSON object matching the input structure. Do not include any other text.
        """
        
        # Process the AI task
        content = await ai_worker.process_task(
            task_type="text_generation",
            prompt=prompt
        )
        
        # Parse the response to ensure it's valid JSON
        # The AI worker returns a string, we rely on the client to parse it or we parse it here to validate
        import json
        try:
            # content is already cleaned (markdown stripped) by GeminiProvider
            result = json.loads(content)
            return result
        except json.JSONDecodeError:
            # If strictly valid JSON isn't returned, try to find it
            import re
            json_match = re.search(r'\{[\s\S]*\}', content)
            if json_match:
                return json.loads(json_match.group())
            else:
                 raise ValueError("AI did not return valid JSON")
            
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Job assist failed: {str(e)}"
        )

class CVReviewRequest(BaseModel):
    cv_text: str
    job_requirements: List[str]
    job_description: str
    candidate_name: str

@router.post("/cv-review", dependencies=[allow_any_authenticated_user])
async def review_cv_for_job(request: CVReviewRequest):
    """
    Analyze a candidate's CV against job requirements using AI.
    Returns a detailed review with score, explanation, strengths, and concerns.
    """
    import json
    import re
    
    try:
        # Construct the prompt for AI review - keep it concise to avoid truncation
        prompt = f"""You are an HR expert. Analyze this CV against job requirements and return ONLY a JSON object.

Candidate: {request.candidate_name}

Job Description:
{request.job_description[:1500] if len(request.job_description) > 1500 else request.job_description}

Requirements:
{chr(10).join(f"- {req}" for req in request.job_requirements[:10])}

CV:
{request.cv_text[:3000] if len(request.cv_text) > 3000 else request.cv_text}

Return this exact JSON structure (no markdown, no extra text):
{{"score": 0-100, "explanation": "2-3 sentences max", "suitable": true/false, "strengths": ["max 5 items"], "concerns": ["max 5 items"], "matched_requirements": ["list matched"], "missing_requirements": ["list missing"]}}"""

        # Process the AI review with increased token limit and JSON mode
        content = await ai_worker.process_task(
            task_type="text_generation",
            prompt=prompt,
            max_output_tokens=4000,
            temperature=0.3,  # Lower temperature for more consistent JSON output
            response_mime_type="application/json"  # Force JSON output format
        )
        
        # Parse the response to ensure it's valid JSON
        try:
            result = json.loads(content)
            return {"result": result, "raw_content": content}
        except json.JSONDecodeError as parse_error:
            # If strictly valid JSON isn't returned, try to find and extract it
            json_match = re.search(r'\{[\s\S]*\}', content)
            if json_match:
                try:
                    result = json.loads(json_match.group())
                    return {"result": result, "raw_content": content}
                except json.JSONDecodeError:
                    # JSON found but incomplete/invalid - try to repair
                    pass
            
            # If we get here, JSON extraction failed
            # Log the raw content for debugging
            raw_preview = content[:800] if content else "empty response"
            raise ValueError(f"AI response could not be parsed as JSON. Parse error: {str(parse_error)}. Raw response preview: {raw_preview}")
        
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"CV review failed: {str(e)}"
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"CV review failed: {str(e)}"
        )
