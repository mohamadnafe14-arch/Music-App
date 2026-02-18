from fastapi  import FastAPI, Request 
from pydantic import BaseModel
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
app = FastAPI()
DATABASE_URL = "postgresql://postgres:medo2005#@localhost:5432/postgres5432/music_app"
engine = create_engine(DATABASE_URL)
sessionLocal=sessionmaker(autocommit=False, autoflush=False, bind=engine)
db=sessionLocal()
class UserCreate(BaseModel):
    name: str
    email: str
    password: str
@app.post("/")
async def root(user: UserCreate):
    return "The email of the user is: " + user.email + " and the password is: " + user.password + " and the name is: " + user.name