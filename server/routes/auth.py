import uuid
import jwt # type: ignore
import bcrypt # type: ignore
from fastapi import APIRouter, Depends, HTTPException,Header # type: ignore
from database import get_db
from pydantic_schemas.user_create import UserCreate
from models.user import User
from pydantic_schemas.user_login import UserLogin
from sqlalchemy.orm import Session # type: ignore
router=APIRouter()
SECRET_KEY = "this_is_my_super_secret_key_that_is_more_than_32_bytes"

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
  token = jwt.encode({"user_id":user_db.id}, SECRET_KEY)
  return {"token":token,"user":user_db}
@router.post("/login")
async def login(user: UserLogin,db: Session = Depends(get_db)):
  user_db = db.query(User).filter(User.email==user.email).first()
  if not user_db:
    raise HTTPException(400,"User with this email does not exist")
  if not bcrypt.checkpw(user.password.encode(),user_db.password):
    raise HTTPException(400,"Incorrect email or password")
  token = jwt.encode({"user_id":user_db.id}, SECRET_KEY)
  return {"token":token,"user":user_db}

@router.get("/")
async def current_user_data(
    db: Session = Depends(get_db),
    x_auth_token: str = Header()
):
    if not x_auth_token:
        raise HTTPException(401, "Unauthorized")

    try:
        token = jwt.decode(
            x_auth_token,
            SECRET_KEY,
            algorithms=["HS256"]
        )

        user_id = token.get("user_id")
        if not user_id:
            raise HTTPException(401, "Unauthorized")

        user_db = db.query(User).filter(User.id == user_id).first()
        if not user_db:
            raise HTTPException(401, "Unauthorized")
        return user_db

    except jwt.ExpiredSignatureError:
        raise HTTPException(401, "Token expired")

    except jwt.InvalidTokenError:
        raise HTTPException(401, "Invalid token")