import uuid
import bcrypt
from fastapi import APIRouter, HTTPException
from user_create import UserCreate
from database import db
from models.user import User
router=APIRouter()
@router.post("/signup")
async def root(user: UserCreate):
  user_db = db.query(User).filter(User.email==user.email).first()
  if   user_db:
    raise HTTPException(400,"User with this email does not exist")
  hased_password=bcrypt.hashpw(user.password.encode(),bcrypt.gensalt())
  user_db=User(id=str(uuid.uuid4()),name=user.name,email=user.email,password=hased_password)
  db.add(user_db)
  db.commit()
  db.refresh(user_db)

  return user_db