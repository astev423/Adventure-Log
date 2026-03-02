from sqlalchemy import Column, Integer, String

from db.db import Base


class ReviewTable(Base):
    __tablename__ = "reviews"
    id = Column(Integer, primary_key=True, index=True)
    location_name = Column(String)
    location_coordinates = Column(String)
    location_rating = Column(Integer)
    reason_for_rating = Column(String, nullable=True)
