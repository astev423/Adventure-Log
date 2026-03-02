from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from database import get_db
from models import Review, ReviewTable

app = FastAPI()

# Needed for Flutter web; harmless for mobile/desktop.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/add-review")
#
# IF WE DEFINE THE ARGUMENT AS THE MODEL, FASTAPI AUTOMATICALLY PERFORMS VALIDATION, NO BOILERPLATE
# REQUIRED!!! IT ALSO AUTO GENERATES THE MODEL USING PYDANTIC
#
def add_review(review: Review, db: Session = Depends(get_db)):
    reviews = db.query(ReviewTable).all()
    if not reviews:
        return {"status": "failure", "errorMessage": "Couldn't find review in DB"}

    # FastAPI also serializes returned models into JSON so we don't need to worry about converting
    return {
        "status": "success",
        "message": "Review added successfully",
        "review": review,
    }
