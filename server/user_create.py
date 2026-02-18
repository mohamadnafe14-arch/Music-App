from models.base import BaseModel
class UserCreate(BaseModel):
    name: str
    email: str
    password: str