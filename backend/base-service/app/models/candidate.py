from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, Text, Date, DECIMAL, TIMESTAMP
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from ..database import Base


# ============================================================
# Portal Authentication Models (for candidate portal login)
# ============================================================

class PortalUser(Base):
    """
    Portal user model for candidate authentication.
    Linked to JobApplication and Candidate (CV data) by email.
    """
    __tablename__ = "portal_users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    full_name = Column(String(150))
    phone = Column(String(50))
    linkedin_url = Column(String(500))
    portfolio_url = Column(String(500))
    is_active = Column(Boolean, default=True)
    email_verified = Column(Boolean, default=False)
    verification_token = Column(String(255))
    reset_token = Column(String(255))
    reset_token_expires = Column(DateTime(timezone=True))
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    # Relationships
    documents = relationship("PortalDocument", back_populates="portal_user", cascade="all, delete-orphan")


class PortalDocument(Base):
    """
    Store uploaded verification documents for portal users.
    """
    __tablename__ = "portal_documents"

    id = Column(Integer, primary_key=True, index=True)
    portal_user_id = Column(Integer, ForeignKey("portal_users.id"), nullable=False, index=True)
    application_id = Column(Integer, ForeignKey("job_applications.id"), nullable=False, index=True)
    document_type = Column(String(50), nullable=False)
    title = Column(String(200))
    file_url = Column(String(500), nullable=False)
    file_name = Column(String(255))
    file_size = Column(Integer)
    mime_type = Column(String(100))
    status = Column(String(20), default="pending", nullable=False)
    uploaded_at = Column(DateTime(timezone=True), server_default=func.now())
    reviewed_at = Column(DateTime(timezone=True))
    reviewed_by = Column(Integer, ForeignKey("users.id"))
    reviewer_notes = Column(Text)

    # Relationships
    portal_user = relationship("PortalUser", back_populates="documents")


# ============================================================
# Candidate CV Data Models (from CV parsing)
# ============================================================

class Candidate(Base):
    """Candidate profile parsed from CV"""
    __tablename__ = "candidates"
    
    id = Column(Integer, primary_key=True, index=True)
    candidate_id = Column(String(50), unique=True, nullable=False, index=True)
    full_name = Column(String(200), nullable=False)
    email = Column(String(255), index=True)
    phone = Column(String(50))
    original_filename = Column(String(255))
    file_url = Column(String(500))
    source = Column(String(100), default='CV Upload - AI Parsed')
    completeness_score = Column(Integer, default=0)
    profile_status = Column(String(50), default='Complete')
    total_experience_years = Column(DECIMAL(4, 1), default=0)
    current_position = Column(String(200))
    current_company = Column(String(200))
    highest_degree = Column(String(100))
    field_of_study = Column(String(150))
    institution = Column(String(200))
    certifications_count = Column(Integer, default=0)
    projects_count = Column(Integer, default=0)
    volunteering_count = Column(Integer, default=0)
    timestamp = Column(TIMESTAMP(timezone=True), server_default=func.now())
    processed_date = Column(TIMESTAMP(timezone=True), server_default=func.now())
    last_updated = Column(TIMESTAMP(timezone=True), server_default=func.now())
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    updated_at = Column(TIMESTAMP(timezone=True), onupdate=func.now())


class CandidateWorkExperience(Base):
    __tablename__ = "candidate_work_experience"
    
    id = Column(Integer, primary_key=True, index=True)
    candidate_id = Column(String(50), ForeignKey("candidates.candidate_id", ondelete="CASCADE"), nullable=False, index=True)
    job_title = Column(String(150), nullable=False)
    company = Column(String(200), nullable=False)
    employment_type = Column(String(50))
    country = Column(String(100))
    city = Column(String(100))
    start_date = Column(Date, nullable=False)
    end_date = Column(Date)
    is_current = Column(Boolean, default=False)
    description = Column(Text)
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    updated_at = Column(TIMESTAMP(timezone=True), onupdate=func.now())


class CandidateEducation(Base):
    __tablename__ = "candidate_education"
    
    id = Column(Integer, primary_key=True, index=True)
    candidate_id = Column(String(50), ForeignKey("candidates.candidate_id", ondelete="CASCADE"), nullable=False, index=True)
    institution = Column(String(200), nullable=False)
    degree = Column(String(150))
    field_of_study = Column(String(150))
    gpa = Column(String(20))
    start_date = Column(Date)
    end_date = Column(Date)
    is_current = Column(Boolean, default=False)
    thesis = Column(Text)
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    updated_at = Column(TIMESTAMP(timezone=True), onupdate=func.now())


class CandidateTechnicalSkill(Base):
    __tablename__ = "candidate_technical_skills"
    
    id = Column(Integer, primary_key=True, index=True)
    candidate_id = Column(String(50), ForeignKey("candidates.candidate_id", ondelete="CASCADE"), nullable=False, index=True)
    skill_category_id = Column(Integer)
    skill_name = Column(String(150), nullable=False)
    proficiency_level = Column(String(50))
    years_of_experience = Column(DECIMAL(4, 1))
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    updated_at = Column(TIMESTAMP(timezone=True), onupdate=func.now())


class CandidateSoftSkill(Base):
    __tablename__ = "candidate_soft_skills"
    
    id = Column(Integer, primary_key=True, index=True)
    candidate_id = Column(String(50), ForeignKey("candidates.candidate_id", ondelete="CASCADE"), nullable=False, index=True)
    skill_name = Column(String(100), nullable=False)
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())


class CandidateRawData(Base):
    __tablename__ = "candidate_raw_data"
    
    id = Column(Integer, primary_key=True, index=True)
    candidate_id = Column(String(50), ForeignKey("candidates.candidate_id", ondelete="CASCADE"), nullable=False, unique=True, index=True)
    raw_structured_data = Column(JSONB)
    n8n_response = Column(JSONB)
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
