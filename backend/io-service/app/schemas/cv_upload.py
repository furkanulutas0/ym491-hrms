from pydantic import BaseModel
from typing import Optional, List, Dict, Any


class MissingFieldsDetail(BaseModel):
    awarded_fields: List[str] = []
    missing_fields: List[str] = []


class CoverageBreakdown(BaseModel):
    personal_information: int = 0
    summary: int = 0
    work_experience: int = 0
    education: int = 0
    skills: int = 0
    projects: int = 0
    certifications: int = 0
    publications: int = 0
    awards: int = 0
    volunteering: int = 0
    additional_information: int = 0


class CoverageDetails(BaseModel):
    personal_information: Optional[MissingFieldsDetail] = None
    summary: Optional[MissingFieldsDetail] = None
    work_experience: Optional[MissingFieldsDetail] = None
    education: Optional[MissingFieldsDetail] = None
    skills: Optional[MissingFieldsDetail] = None
    projects: Optional[MissingFieldsDetail] = None
    certifications: Optional[MissingFieldsDetail] = None
    publications: Optional[MissingFieldsDetail] = None
    awards: Optional[MissingFieldsDetail] = None
    volunteering: Optional[MissingFieldsDetail] = None
    additional_information: Optional[MissingFieldsDetail] = None


class CoverageResponse(BaseModel):
    cover_rate: float
    breakdown: CoverageBreakdown
    details: CoverageDetails
    file_url: str


class UploadAndCheckResponse(BaseModel):
    success: bool
    file_url: str
    coverage: Optional[CoverageResponse] = None
    error: Optional[str] = None


class AdditionalFields(BaseModel):
    """Fields that can be provided by user to supplement CV data."""
    city: Optional[str] = None
    country: Optional[str] = None
    languages: Optional[List[str]] = None
    driving_license: Optional[str] = None
    military_status: Optional[str] = None
    availability: Optional[str] = None
    willing_to_relocate: Optional[bool] = None
    willing_to_travel: Optional[bool] = None
    hobbies: Optional[List[str]] = None


class AnalyzeRequest(BaseModel):
    file_url: str
    additional_fields: Optional[AdditionalFields] = None


class AnalyzedCVResponse(BaseModel):
    success: bool
    data: Optional[Dict[str, Any]] = None
    error: Optional[str] = None


class CreateApplicationRequest(BaseModel):
    job_posting_id: int
    candidate_name: str
    email: str
    phone: Optional[str] = None
    resume_url: str
    cover_letter: Optional[str] = None
    portfolio_url: Optional[str] = None
    linkedin_url: Optional[str] = None
    source: str = "Career Page"
    analyzed_cv_data: Optional[Dict[str, Any]] = None

