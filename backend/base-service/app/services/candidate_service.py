from datetime import datetime, timedelta
from typing import Optional
import secrets
from sqlalchemy.orm import Session
from fastapi import HTTPException, status

from ..models.candidate import PortalUser, PortalDocument
from ..models.recruitment import JobApplication
from ..schemas.candidate import (
    CandidateRegister, CandidateToken, CandidateResponse,
    CandidateProfileUpdate, DocumentCreate, DocumentResponse
)
from ..core.security import SecurityUtils, ACCESS_TOKEN_EXPIRE_MINUTES


class CandidateService:
    def __init__(self, db: Session):
        self.db = db

    def get_candidate_by_email(self, email: str) -> Optional[PortalUser]:
        """Get candidate by email"""
        return self.db.query(PortalUser).filter(PortalUser.email == email).first()

    def get_candidate_by_id(self, candidate_id: int) -> Optional[PortalUser]:
        """Get candidate by ID"""
        return self.db.query(PortalUser).filter(PortalUser.id == candidate_id).first()

    def register_candidate(self, data: CandidateRegister) -> CandidateToken:
        """Register a new candidate"""
        # Check if candidate already exists
        existing = self.get_candidate_by_email(data.email)
        if existing:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email already registered"
            )

        # Create new candidate
        hashed_password = SecurityUtils.get_password_hash(data.password)
        verification_token = secrets.token_urlsafe(32)
        
        candidate = PortalUser(
            email=data.email,
            hashed_password=hashed_password,
            full_name=data.full_name,
            phone=data.phone,
            verification_token=verification_token,
            email_verified=False,
            is_active=True
        )
        
        self.db.add(candidate)
        self.db.commit()
        self.db.refresh(candidate)

        # Generate access token
        access_token = SecurityUtils.create_access_token(
            data={"sub": candidate.email, "type": "candidate", "candidate_id": candidate.id}
        )

        return CandidateToken(
            access_token=access_token,
            token_type="bearer",
            candidate=CandidateResponse.model_validate(candidate)
        )

    def authenticate_candidate(self, email: str, password: str) -> CandidateToken:
        """Authenticate a candidate and return token"""
        candidate = self.get_candidate_by_email(email)
        
        if not candidate:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid email or password"
            )
        
        if not SecurityUtils.verify_password(password, candidate.hashed_password):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid email or password"
            )
        
        if not candidate.is_active:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Account is inactive"
            )

        # Generate access token
        access_token = SecurityUtils.create_access_token(
            data={"sub": candidate.email, "type": "candidate", "candidate_id": candidate.id}
        )

        return CandidateToken(
            access_token=access_token,
            token_type="bearer",
            candidate=CandidateResponse.model_validate(candidate)
        )

    def request_password_reset(self, email: str) -> bool:
        """Generate password reset token"""
        candidate = self.get_candidate_by_email(email)
        
        if not candidate:
            # Return True anyway to prevent email enumeration
            return True
        
        # Generate reset token
        reset_token = secrets.token_urlsafe(32)
        candidate.reset_token = reset_token
        candidate.reset_token_expires = datetime.utcnow() + timedelta(hours=24)
        
        self.db.commit()
        
        # TODO: Send email with reset link
        # For now, just return True
        return True

    def reset_password(self, token: str, new_password: str) -> bool:
        """Reset password using token"""
        candidate = self.db.query(PortalUser).filter(
            PortalUser.reset_token == token,
            PortalUser.reset_token_expires > datetime.utcnow()
        ).first()
        
        if not candidate:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid or expired reset token"
            )
        
        # Update password
        candidate.hashed_password = SecurityUtils.get_password_hash(new_password)
        candidate.reset_token = None
        candidate.reset_token_expires = None
        
        self.db.commit()
        return True

    def update_profile(self, candidate_id: int, data: CandidateProfileUpdate) -> PortalUser:
        """Update candidate profile"""
        candidate = self.get_candidate_by_id(candidate_id)
        
        if not candidate:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Candidate not found"
            )
        
        # Update fields
        update_data = data.model_dump(exclude_unset=True)
        for field, value in update_data.items():
            setattr(candidate, field, value)
        
        self.db.commit()
        self.db.refresh(candidate)
        return candidate

    def get_applications(self, candidate_email: str) -> list[JobApplication]:
        """Get all applications for a candidate by email"""
        applications = self.db.query(JobApplication).filter(
            JobApplication.email == candidate_email
        ).order_by(JobApplication.applied_at.desc()).all()
        
        return applications

    def get_application(self, candidate_email: str, application_id: int) -> Optional[JobApplication]:
        """Get specific application for a candidate"""
        application = self.db.query(JobApplication).filter(
            JobApplication.id == application_id,
            JobApplication.email == candidate_email
        ).first()
        
        return application

    def get_documents(self, candidate_id: int, application_id: int) -> list[PortalDocument]:
        """Get all documents for an application"""
        return self.db.query(PortalDocument).filter(
            PortalDocument.portal_user_id == candidate_id,
            PortalDocument.application_id == application_id
        ).all()

    def create_document(self, candidate_id: int, data: DocumentCreate) -> PortalDocument:
        """Create a new document record"""
        document = PortalDocument(
            portal_user_id=candidate_id,
            application_id=data.application_id,
            document_type=data.document_type,
            title=data.title,
            file_url=data.file_url,
            file_name=data.file_name,
            file_size=data.file_size,
            mime_type=data.mime_type,
            status="pending"
        )
        
        self.db.add(document)
        self.db.commit()
        self.db.refresh(document)
        
        return document

    def verify_application_ownership(self, candidate_email: str, application_id: int) -> bool:
        """Verify that an application belongs to a candidate"""
        application = self.db.query(JobApplication).filter(
            JobApplication.id == application_id,
            JobApplication.email == candidate_email
        ).first()
        
        return application is not None

