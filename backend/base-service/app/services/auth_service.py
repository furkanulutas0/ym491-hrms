from sqlalchemy.orm import Session
from fastapi import HTTPException, status
from ..repositories.user_repository import UserRepository
from ..schemas.user import UserCreate, Token
from ..core.security import SecurityUtils

class AuthService:
    def __init__(self, db: Session):
        self.user_repository = UserRepository(db)

    def register_user(self, user: UserCreate) -> Token:
        # Check if user already exists
        if self.user_repository.get_user_by_email(user.email):
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email already registered"
            )

        # Hash password and create user
        hashed_password = SecurityUtils.get_password_hash(user.password)
        new_user = self.user_repository.create_user(user, hashed_password)

        # Generate token
        access_token = SecurityUtils.create_access_token(data={"sub": new_user.email})
        return Token(access_token=access_token, token_type="bearer")

    def authenticate_user(self, email: str, password: str) -> Token:
        user = self.user_repository.get_user_by_email(email)
        if not user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect email or password",
                headers={"WWW-Authenticate": "Bearer"},
            )
        
        if not SecurityUtils.verify_password(password, user.hashed_password):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect email or password",
                headers={"WWW-Authenticate": "Bearer"},
            )

        # Generate token
        access_token = SecurityUtils.create_access_token(data={"sub": user.email})
        return Token(access_token=access_token, token_type="bearer")

