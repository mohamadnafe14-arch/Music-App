from sqlalchemy.orm import sessionmaker
from sqlalchemy import TEXT, VARCHAR, Column, LargeBinary, create_engine
from sqlalchemy.ext.declarative import declarative_base


DATABASE_URL = "postgresql://postgres:medo2005%23@localhost:5432/music_app"
engine = create_engine(DATABASE_URL)
sessionLocal=sessionmaker(autocommit=False, autoflush=False, bind=engine)
db=sessionLocal()

Base=declarative_base()

Base.metadata.create_all(engine)  