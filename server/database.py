from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models.base import Base
DATABASE_URL = "postgresql://postgres:medo2005%23@localhost:5432/music_app"
engine = create_engine(DATABASE_URL)
sessionLocal=sessionmaker(autocommit=False, autoflush=False, bind=engine)
db=sessionLocal()
