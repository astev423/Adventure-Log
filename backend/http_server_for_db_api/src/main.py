import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from db.db import engine
from db.models import Review

# FastAPI makes ASGI app which we must be top level since uvicorn imports this file and if its in main
# it wont' run
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def health():
    return {"status": "Up and running!"}


# Response model parameter is for even more validation on the return
@app.post("/add-review", response_model=Review)
def add_review(review: Review):
    # Imported objects are stored in python cache so we can use like a static singleton
    # Also we use with which will automatically close the session after its done
    with Session(engine) as session:
        session.add(review)
        session.commit()
        # Need to refresh to get fields, or else nothing returned
        session.refresh(review)
        return review


# We must setup all the fastAPI stuff first since uvicorn depends on it, then run it down here
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
