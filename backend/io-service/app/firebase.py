import os
import firebase_admin
from firebase_admin import credentials, firestore

# Path to your service account key file
# You should mount this file via Docker volume
CREDENTIALS_PATH = os.getenv("FIREBASE_CREDENTIALS_PATH", "firebase-credentials.json")

def initialize_firebase():
    if not firebase_admin._apps:
        if os.path.exists(CREDENTIALS_PATH):
            cred = credentials.Certificate(CREDENTIALS_PATH)
            firebase_admin.initialize_app(cred)
            print("Firebase initialized successfully.")
        else:
            print(f"Warning: Firebase credentials not found at {CREDENTIALS_PATH}. Firebase not initialized.")

def get_firestore_client():
    if not firebase_admin._apps:
        initialize_firebase()
    try:
        return firestore.client()
    except ValueError:
        return None

