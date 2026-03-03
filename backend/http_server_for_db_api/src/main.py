from typing import List

import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from db.models import Review
from db.queries import create_review_row, fetch_reviews

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


# Response model parameter is for validation on the return
@app.get("/get-reviews", response_model=List[Review])
def get_reviews():
    return fetch_reviews()


@app.post("/add-review", response_model=Review)
def add_review(review: Review):
    return create_review_row(review)


# We must setup all the fastAPI stuff first since uvicorn depends on it, then run it down here
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
