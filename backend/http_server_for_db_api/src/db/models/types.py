from typing import Optional

from pydantic import BaseModel, Field


# ALSO, CONVERT THESE TO DART MODELS WITH OPENAPI CONVERSION CLI TOOL
# Because we are using pydantic JSON reqs gets automatically converted to the models or returns error if
# conversion is not possible
class Review(BaseModel):
    id: Optional[int] = None
    location_name: str
    location_coordinates: str
    location_rating: int = Field(gt=0, lt=6)
    reason_for_rating: Optional[str] = None
    location_image: Optional[str] = None
