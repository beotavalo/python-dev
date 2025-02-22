from fastapi import FastAPI

from . import models
from .database import engine

models.Base.metadata.create_all(bind=engine)
app = FastAPI()


@app.get("/")
def read_root():
    return {"message": "Welcome to the Todo App!"}
