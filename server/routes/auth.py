import uuid
import bcrypt # type: ignore
from fastapi import APIRouter, Depends, HTTPException # type: ignore
from database import get_db
from pydantic_schemas.user_create import UserCreate
from models.user import User
from pydantic_schemas.user_login import UserLogin
from sqlalchemy.orm import Session # type: ignore
router=APIRouter()
@router.post("/signup",status_code=201)
async def signup(user: UserCreate,db: Session = Depends(get_db)):
  user_db = db.query(User).filter(User.email==user.email).first()
  if   user_db:
    raise HTTPException(400,"User with this email already exist")
  hased_password=bcrypt.hashpw(user.password.encode(),bcrypt.gensalt())
  user_db=User(id=str(uuid.uuid4()),name=user.name,email=user.email,password=hased_password)
  db.add(user_db)
  db.commit()
  db.refresh(user_db)

  return user_db
@router.post("/login")
async def login(user: UserLogin,db: Session = Depends(get_db)):
  user_db = db.query(User).filter(User.email==user.email).first()
  if not user_db:
    raise HTTPException(400,"User with this email does not exist")
  if not bcrypt.checkpw(user.password.encode(),user_db.password):
    raise HTTPException(400,"Incorrect email or password")
  return user_db