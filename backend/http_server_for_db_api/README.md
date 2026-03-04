## Swap to firestore
Use nosql for practice, for efficiency denormalize data (store user info in reviews) for faster lookups as joins are slow on nosql

## Design and why
Using SQLModel to reduce needing seperate model for API and separate model for db table. This avoids some
boilerplate but what if I only want to get certain info and not everything in db table? Then this breaks 
down. Overall I think it is better to just write two separate models as it provides much more flexibility

## How to run
Simply type:

` uv sync `

and then

` uv run python src/main.py `
