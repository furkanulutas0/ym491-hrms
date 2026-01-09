from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime


# ============ Candidate Auth Schemas ============

class CandidateRegister(BaseModel):
    """Schema for candidate registration"""
    email: EmailStr
    password: str = Field(..., min_length=8)
    full_name: str = Field(..., min_length=2)
    phone: Optional[str] = None


class CandidateLogin(BaseModel):
    """Schema for candidate login"""
    email: EmailStr
    password: str


class CandidateToken(BaseModel):
    """Token response for candidate auth"""
    access_token: str
    token_type: str = "bearer"
    candidate: "CandidateResponse"


class CandidateForgotPassword(BaseModel):
    """Schema for forgot password request"""
    email: EmailStr


class CandidateResetPassword(BaseModel):
    """Schema for password reset"""
    token: str
    new_password: str = Field(..., min_length=8)


# ============ Candidate Profile Schemas ============

class CandidateBase(BaseModel):
    """Base candidate schema"""
    email: EmailStr
    full_name: Optional[str] = None
    phone: Optional[str] = None
    linkedin_url: Optional[str] = None
    portfolio_url: Optional[str] = None


class CandidateResponse(BaseModel):
    """Response schema for candidate"""
    id: int
    email: str
    full_name: Optional[str] = None
    phone: Optional[str] = None
    linkedin_url: Optional[str] = None
    portfolio_url: Optional[str] = None
    is_active: bool
    email_verified: bool
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class CandidateProfileUpdate(BaseModel):
    """Schema for updating candidate profile"""
    full_name: Optional[str] = None
    phone: Optional[str] = None
    linkedin_url: Optional[str] = None
    portfolio_url: Optional[str] = None


# ============ Document Schemas ============

class DocumentBase(BaseModel):
    """Base document schema"""
    document_type: str
    title: Optional[str] = None


class DocumentCreate(DocumentBase):
    """Schema for creating a document record"""
    application_id: int
    file_url: str
    file_name: Optional[str] = None
    file_size: Optional[int] = None
    mime_type: Optional[str] = None


class DocumentResponse(BaseModel):
    """Response schema for document"""
    id: int
    portal_user_id: int
    application_id: int
    document_type: str
    title: Optional[str] = None
    file_url: str
    file_name: Optional[str] = None
    file_size: Optional[int] = None
    mime_type: Optional[str] = None
    status: str
    uploaded_at: datetime
    reviewed_at: Optional[datetime] = None
    reviewed_by: Optional[int] = None
    reviewer_notes: Optional[str] = None

    class Config:
        from_attributes = True


class DocumentReview(BaseModel):
    """Schema for HR reviewing a document"""
    status: str = Field(..., pattern="^(approved|rejected)$")
    reviewer_notes: Optional[str] = None


class DocumentRequirementStatus(BaseModel):
    """Schema for document requirement with status"""
    document_type: str
    title: str
    description: Optional[str] = None
    required: bool
    submitted: bool = False
    status: Optional[str] = None  # pending, approved, rejected
    document: Optional[DocumentResponse] = None


# ============ Application View Schemas ============

class CandidateApplicationSummary(BaseModel):
    """Summary of application for candidate view"""
    id: int
    job_title: str
    company_name: str = "HRiQ Inc."
    department: Optional[str] = None
    location: Optional[str] = None
    pipeline_stage: str
    applied_at: datetime
    status: str
    
    # Stage-specific info
    exam_assigned: bool = False
    exam_completed: bool = False
    exam_score: Optional[int] = None
    interview_scheduled: bool = False
    interview_completed: bool = False
    interview_type: Optional[str] = None
    interview_scheduled_at: Optional[datetime] = None
    documents_pending: int = 0
    documents_approved: int = 0
    proposal_sent: bool = False
    proposal_accepted: Optional[bool] = None

    class Config:
        from_attributes = True


class CandidateApplicationDetail(CandidateApplicationSummary):
    """Full application detail for candidate view"""
    job_description: Optional[str] = None
    exam_access_code: Optional[str] = None
    exam_platform_id: Optional[str] = None
    documents: list[DocumentResponse] = []
    document_requirements: list[DocumentRequirementStatus] = []


class InterviewInfo(BaseModel):
    """Interview information for candidate"""
    interview_type: Optional[str] = None  # video or voice
    scheduled_at: Optional[datetime] = None
    completed_at: Optional[datetime] = None
    meeting_url: Optional[str] = None
    instructions: Optional[str] = None


class ExamInfo(BaseModel):
    """Exam information for candidate"""
    assigned: bool = False
    platform_id: Optional[str] = None
    access_code: Optional[str] = None
    exam_url: Optional[str] = None
    started_at: Optional[datetime] = None
    completed_at: Optional[datetime] = None
    score: Optional[int] = None
    instructions: Optional[str] = None


class ProposalInfo(BaseModel):
    """Proposal information for candidate"""
    sent_at: Optional[datetime] = None
    accepted: Optional[bool] = None
    position: Optional[str] = None
    salary_offer: Optional[int] = None
    salary_currency: Optional[str] = "USD"
    start_date: Optional[str] = None
    benefits: list[str] = []
    additional_notes: Optional[str] = None


class ProposalResponse(BaseModel):
    """Schema for candidate responding to proposal"""
    accepted: bool
    notes: Optional[str] = None


# Update forward references
CandidateToken.model_rebuild()

