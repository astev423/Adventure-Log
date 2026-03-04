from os import getenv

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlmodel import SQLModel

load_dotenv()

DB_HOST = getenv("DB_HOST")
DB_PORT = getenv("DB_PORT")
DB_NAME = getenv("DB_NAME")
DB_USER = getenv("DB_USER")
DB_PASS = getenv("DB_PASS")

SQLALCHEMY_DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(SQLALCHEMY_DATABASE_URL)
get_new_session = sessionmaker(bind=engine)

# Import modules so SQLModel knows to make them
from db.models import *

SQLModel.metadata.create_all(engine)


"""
I don't need to add stuff above to main, it runs first time module is imported, this is because python
is interpreted, other interpreted languages behave like this too (lua, ruby, perl).
This info in then stored in cache so it doesn't get ran again on next import
For packages python runs the __init__.py file for the first time and also the module in that package
For compiled languages like Rust and C, code can only run via main, usually imports there are copy pasting
code or linking to it
"""
