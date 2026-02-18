from fastapi  import FastAPI, Request 
from pydantic import BaseModel
app = FastAPI()
class UserCreate(BaseModel):
    name: str
    email: str
    password: str
@app.post("/")
async def root(user: UserCreate):
    return "The email of the user is: " + user.email + " and the password is: " + user.password + " and the name is: " + user.name