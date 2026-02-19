from models.base import Base


class UserLogin(Base):
    username: str
    password: str