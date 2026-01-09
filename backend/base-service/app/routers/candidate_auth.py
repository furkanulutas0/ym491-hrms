from fastapi import APIRouter, Depends, status, HTTPException
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from jose import JWTError, jwt

from ..database import get_db
from ..schemas.candidate import (
    CandidateRegister, CandidateLogin, CandidateToken, CandidateResponse,
    CandidateForgotPassword, CandidateResetPassword
)
from ..services.candidate_service import CandidateService
from ..models.candidate import PortalUser
from ..core.security import SECRET_KEY, ALGORITHM

router = APIRouter(
    prefix="/candidate/auth",
    tags=["Candidate Authentication"],
)

# Separate OAuth2 scheme for candidates
candidate_oauth2_scheme = OAuth2PasswordBearer(tokenUrl="candidate/auth/token", auto_error=False)


def get_current_candidate(
    token: str = Depends(candidate_oauth2_scheme),
    db: Session = Depends(get_db)
) -> PortalUser:
    """Get current authenticated candidate from JWT token"""
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    
    if not token:
        raise credentials_exception
    
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        token_type: str = payload.get("type")
        
        if email is None or token_type != "candidate":
            raise credentials_exception
            
    except JWTError:
        raise credentials_exception
    
    service = CandidateService(db)
    candidate = service.get_candidate_by_email(email)
    
    if candidate is None:
        raise credentials_exception
    
    if not candidate.is_active:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Account is inactive"
        )
    
    return candidate


def get_current_active_candidate(
    current_candidate: PortalUser = Depends(get_current_candidate)
) -> PortalUser:
    """Ensure candidate is active"""
    if not current_candidate.is_active:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Inactive candidate"
        )
    return current_candidate


@router.post("/register", response_model=CandidateToken, status_code=status.HTTP_201_CREATED)
def register_candidate(
    data: CandidateRegister,
    db: Session = Depends(get_db)
):
    """
    Register a new candidate account.
    
    This is typically called after a candidate applies for a job and wants to
    track their application status.
    """
    service = CandidateService(db)
    return service.register_candidate(data)


@router.post("/login", response_model=CandidateToken)
def login_candidate(
    data: CandidateLogin,
    db: Session = Depends(get_db)
):
    """
    Authenticate candidate and return access token.
    """
    service = CandidateService(db)
    return service.authenticate_candidate(data.email, data.password)


@router.post("/token", response_model=CandidateToken)
def login_for_access_token(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    """
    OAuth2 compatible token login endpoint.
    """
    service = CandidateService(db)
    return service.authenticate_candidate(form_data.username, form_data.password)


@router.get("/me", response_model=CandidateResponse)
def get_current_candidate_info(
    current_candidate: PortalUser = Depends(get_current_active_candidate)
):
    """
    Get current authenticated candidate's profile.
    """
    return current_candidate


@router.post("/forgot-password", status_code=status.HTTP_200_OK)
def forgot_password(
    data: CandidateForgotPassword,
    db: Session = Depends(get_db)
):
    """
    Request password reset email.
    
    Always returns success to prevent email enumeration.
    """
    service = CandidateService(db)
    service.request_password_reset(data.email)
    return {"message": "If an account exists with this email, a password reset link has been sent."}


@router.post("/reset-password", status_code=status.HTTP_200_OK)
def reset_password(
    data: CandidateResetPassword,
    db: Session = Depends(get_db)
):
    """
    Reset password using token from email.
    """
    service = CandidateService(db)
    service.reset_password(data.token, data.new_password)
    return {"message": "Password has been reset successfully."}

