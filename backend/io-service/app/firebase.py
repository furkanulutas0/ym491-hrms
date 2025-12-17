import os
import firebase_admin
from firebase_admin import credentials, storage

# Path to your service account key file
# You should mount this file via Docker volume
CREDENTIALS_PATH = os.getenv("FIREBASE_CREDENTIALS_PATH", "/firebase-credentials.json")
STORAGE_BUCKET = os.getenv("FIREBASE_STORAGE_BUCKET", "ym491-hrms.appspot.com")

def initialize_firebase():
    if not firebase_admin._apps:
        if os.path.exists(CREDENTIALS_PATH):
            cred = credentials.Certificate(CREDENTIALS_PATH)
            firebase_admin.initialize_app(cred, {
                'storageBucket': STORAGE_BUCKET
            })
            print("Firebase initialized successfully with Storage.")
        else:
            raise ValueError(f"Firebase credentials not found at {CREDENTIALS_PATH}")

def get_storage_bucket():
    """Get Firebase Storage bucket instance."""
    if not firebase_admin._apps:
        initialize_firebase()
    return storage.bucket()
