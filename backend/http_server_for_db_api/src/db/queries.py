from sqlmodel import Session, select

from db.db import engine
from db.models import Review


def fetch_reviews():
    # Imported objects are stored in python cache so we can use like a static singleton
    # Also we use with which will automatically close the session after its done
    with Session(engine) as session:
        reviews = session.exec(select(Review)).all()
        return reviews


def create_review_row(review: Review):
    with Session(engine) as session:
        session.add(review)
        session.commit()
        # Need to refresh to get fields after adding, or else nothing returned
        session.refresh(review)
        return review
