"""
Document Upload Router for Candidate Portal

Handles file uploads for verification documents (ID, diplomas, certificates, etc.)
"""
import os
import re
import uuid
from datetime import datetime
from pathlib import Path
from typing import Optional
from fastapi import APIRouter, File, UploadFile, HTTPException, Form, Query
from fastapi.responses import FileResponse, Response
from pydantic import BaseModel
import logging

# Create uploads directory for documents
DOCUMENTS_DIR = Path("/app/documents")
DOCUMENTS_DIR.mkdir(parents=True, exist_ok=True)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Allowed file types
ALLOWED_EXTENSIONS = {'.pdf', '.jpg', '.jpeg', '.png', '.doc', '.docx'}
ALLOWED_MIME_TYPES = {
    'application/pdf',
    'image/jpeg',
    'image/png',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
}
MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 MB

router = APIRouter(
    prefix="/documents",
    tags=["documents"],
    responses={404: {"description": "Not found"}},
)


class DocumentUploadResponse(BaseModel):
    """Response schema for document upload"""
    success: bool
    file_url: str
    file_name: str
    file_size: int
    mime_type: str
    document_type: str
    application_id: int


@router.post("/upload", response_model=DocumentUploadResponse)
async def upload_verification_document(
    file: UploadFile = File(...),
    document_type: str = Form(...),
    application_id: int = Form(...)
):
    """
    Upload a verification document.
    
    Accepts PDF, images (JPG, PNG), and Word documents.
    Files are stored in /app/documents/{application_id}/
    
    Parameters:
    - file: The document file to upload
    - document_type: Type of document (id_card, diploma, certificate, reference)
    - application_id: The application this document belongs to
    
    Returns:
    - file_url: URL to access the uploaded file
    - file_name: Original filename
    - file_size: Size in bytes
    - mime_type: MIME type of the file
    """
    # Validate document type
    valid_types = ['id_card', 'diploma', 'certificate', 'reference', 'other']
    if document_type not in valid_types:
        raise HTTPException(
            status_code=400,
            detail=f"Invalid document type. Must be one of: {', '.join(valid_types)}"
        )
    
    # Validate file extension
    if not file.filename:
        raise HTTPException(status_code=400, detail="Filename is required")
    
    file_ext = Path(file.filename).suffix.lower()
    if file_ext not in ALLOWED_EXTENSIONS:
        raise HTTPException(
            status_code=400,
            detail=f"File type not allowed. Allowed types: {', '.join(ALLOWED_EXTENSIONS)}"
        )
    
    # Validate MIME type
    if file.content_type and file.content_type not in ALLOWED_MIME_TYPES:
        raise HTTPException(
            status_code=400,
            detail=f"MIME type not allowed: {file.content_type}"
        )
    
    try:
        # Read file content
        file_content = await file.read()
        
        # Validate file size
        file_size = len(file_content)
        if file_size > MAX_FILE_SIZE:
            raise HTTPException(
                status_code=400,
                detail=f"File too large. Maximum size is {MAX_FILE_SIZE // (1024 * 1024)} MB"
            )
        
        # Create application-specific directory
        app_dir = DOCUMENTS_DIR / str(application_id)
        app_dir.mkdir(parents=True, exist_ok=True)
        
        # Generate unique filename
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        unique_id = str(uuid.uuid4())[:8]
        safe_filename = re.sub(r'[^a-zA-Z0-9._-]', '_', file.filename)
        filename = f"{document_type}_{timestamp}_{unique_id}_{safe_filename}"
        file_path = app_dir / filename
        
        # Save file
        with open(file_path, "wb") as f:
            f.write(file_content)
        
        logger.info(f"Document saved: {file_path}")
        
        # Generate URL for accessing the file
        file_url = f"/api/io/documents/files/{application_id}/{filename}"
        
        return DocumentUploadResponse(
            success=True,
            file_url=file_url,
            file_name=file.filename,
            file_size=file_size,
            mime_type=file.content_type or "application/octet-stream",
            document_type=document_type,
            application_id=application_id
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error uploading document: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to upload document: {str(e)}")


@router.get("/files/{application_id}/{filename}")
async def get_document_file(
    application_id: int, 
    filename: str,
    download: bool = Query(False, description="Set to true to download instead of preview")
):
    """
    Retrieve an uploaded document file.
    
    By default, files are served inline for preview in the browser.
    Add ?download=true to force download.
    
    Parameters:
    - application_id: The application ID
    - filename: The filename of the document
    - download: If true, force download instead of inline preview
    """
    file_path = DOCUMENTS_DIR / str(application_id) / filename
    
    if not file_path.exists():
        raise HTTPException(status_code=404, detail="Document not found")
    
    # Determine media type from extension
    ext = file_path.suffix.lower()
    media_types = {
        '.pdf': 'application/pdf',
        '.jpg': 'image/jpeg',
        '.jpeg': 'image/jpeg',
        '.png': 'image/png',
        '.doc': 'application/msword',
        '.docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    }
    media_type = media_types.get(ext, 'application/octet-stream')
    
    # Read file content
    with open(file_path, "rb") as f:
        file_content = f.read()
    
    # Set Content-Disposition header based on download parameter
    if download:
        content_disposition = f'attachment; filename="{filename}"'
    else:
        # Inline display for preview
        content_disposition = f'inline; filename="{filename}"'
    
    return Response(
        content=file_content,
        media_type=media_type,
        headers={
            "Content-Disposition": content_disposition,
            "Cache-Control": "public, max-age=3600",
        }
    )


@router.delete("/files/{application_id}/{filename}")
async def delete_document_file(application_id: int, filename: str):
    """
    Delete an uploaded document file.
    
    Parameters:
    - application_id: The application ID
    - filename: The filename to delete
    """
    file_path = DOCUMENTS_DIR / str(application_id) / filename
    
    if not file_path.exists():
        raise HTTPException(status_code=404, detail="Document not found")
    
    try:
        os.remove(file_path)
        logger.info(f"Document deleted: {file_path}")
        return {"success": True, "message": "Document deleted successfully"}
    except Exception as e:
        logger.error(f"Error deleting document: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to delete document: {str(e)}")

