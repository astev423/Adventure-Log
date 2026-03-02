from typing import Optional

from pydantic import BaseModel, Field
from sqlalchemy import Column, Integer, String

from database import Base


class ReviewTable(Base):
    __tablename__ = "reviews"
    id = Column(Integer, primary_key=True, index=True)
    location_name = Column(String)
    location_coordinates = Column(String)
    location_rating = Column(Integer)
    reason_for_rating = Column(String, nullable=True)


# Pydantic Schema (API Response)
class ReviewSchema(BaseModel):
    id: int
    location_name: str
    location_rating: int

    class Config:
        from_attributes = True


# Because we are using pydantic JSON reqs gets automatically converted to the models or returns error if
# conversion is not possible
class Review(BaseModel):
    location_name: str
    location_coordinates: str
    location_rating: int = Field(gt=0, lt=6)
    reason_for_rating: Optional[str] = None
    location_image: Optional[str] = None
