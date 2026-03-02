import uvicorn
from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from db.db import get_db
from db.models.tables import ReviewTable
from db.models.types import Review

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


@app.get("/health")
def health():
    return {"status": "Up and running!"}


@app.post("/add-review")
# Since get_db is a generator we use Depends so fastapi can handle calling .close() on it
# Once FastAPI is done with generators it calls .close on them, which triggers the finally block
# in my get_db function, which closes the db connection, this saves a lot of manual calling .close()
# after every query, nice QOL feature
def add_review(review: Review, db: Session = Depends(get_db)):
    reviews = db.query(ReviewTable).all()
    if not reviews:
        return {"status": "failure", "errorMessage": "Couldn't find review in DB"}

    return {
        "status": "success",
        "message": "Review added successfully",
        "review": review,
    }


# We must setup all the fastAPI stuff first since uvicorn depends on it, then run it down here
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
