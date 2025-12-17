from typing import Union
from fastapi import FastAPI
from .routers import cv
from .routers import cv_upload

app = FastAPI(root_path="/api/io")

app.include_router(cv.router)
app.include_router(cv_upload.router)

# CORS is handled by nginx gateway - no middleware needed here


@app.get("/")
def read_root():
    return {"Hello": "World from IO Service"}


@app.get("/firebase-check")
def check_firebase_connection():
    try:
        initialize_firebase()
        return {"status": "success", "message": "Firebase SDK initialized"}
    except Exception as e:
        return {"status": "error", "message": str(e)}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
