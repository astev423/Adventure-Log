from typing import Optional

from sqlalchemy import CheckConstraint
from sqlmodel import Field, SQLModel


# ALSO, CONVERT THESE TO DART MODELS WITH OPENAPI CONVERSION CLI TOOL
# Because we are using pydantic JSON reqs gets automatically converted to the models or returns error if
# conversion is not possible
class Review(SQLModel, table=True):
    # Table args is for validating sql, Field() is for pydantic
    __table_args__ = (
        CheckConstraint(
            "location_rating BETWEEN 1 AND 5", name="ck_reviews_rating_1_5"
        ),
    )
    id: Optional[int] = Field(default=None, primary_key=True, index=True)
    location_name: str
    location_coordinates: str
    location_rating: int = Field(ge=1, le=5)
    reason_for_rating: Optional[str] = Field(default=None)
    location_image: Optional[str] = Field(default=None)
