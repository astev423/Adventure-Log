from os import getenv

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

# Load dotenv so we can run it without giving .env path in uv
load_dotenv()

DB_HOST = getenv("DB_HOST")
DB_PORT = getenv("DB_PORT")
DB_NAME = getenv("DB_NAME")
DB_USER = getenv("DB_USER")
DB_PASS = getenv("DB_PASS")

SQLALCHEMY_DATABASE_URL = (
    f"postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(SQLALCHEMY_DATABASE_URL)
get_new_session = sessionmaker(bind=engine)
# Base is for table models
Base = declarative_base()

"""
I don't need to add stuff above to main, it runs first time module is imported, this is because python
is interpreted, other interpreted languages behave like this too (lua, ruby, perl).
This info in then stored in cache so it doesn't get ran again on next import
For packages python runs the __init__.py file for the first time and also the module in that package
For compiled languages like Rust and C, code can only run via main, usually imports there are copy pasting
code or linking to it
"""


# Get a new session object we need to interact with db, we must call this each time we make request
# for thread safety and to ensure db transactions (all or nothing)
def get_db():
    db = get_new_session()
    # Using yield allows us to give the database and ensure that the finally block runs
    # and closes the db connection once the request is done because this is a GENERATOR
    try:
        yield db
    # The finally block activates when generator is exhausted, we call .close() on it, or error occurs in
    # try block
    finally:
        db.close()
