from random import choice
from typing import Annotated, Tuple
import hashlib
import base64
from string import ascii_uppercase, digits, ascii_lowercase
from uuid import uuid4
import time
import logging

from fastapi import Depends, HTTPException, status
from fastapi.security import APIKeyQuery, OAuth2PasswordBearer
from sqlalchemy.orm import Session

from .data.schemas import User, get_db
from .data import storage_interface
from .data.storage_interface import get_user_for_token, update_user

SALT_CHARACTERS = ascii_uppercase + digits + ascii_lowercase

logger = logging.getLogger(__name__)


def hash_password_with_random_salt(password: str) -> Tuple[str, str]:
    salt = "".join(choice(ascii_uppercase) for i in range(12))
    hash = base64.b64encode(
        hashlib.scrypt(password.encode(), salt=salt.encode(), n=2**14, r=8, p=1)
    )
    return hash, salt


def is_correct_password_for_user(user: User, password: str) -> bool:
    hash = base64.b64encode(
        hashlib.scrypt(password.encode(), salt=user.salt.encode(), n=2**14, r=8, p=1)
    )
    return hash == user.password_hash


async def create_user(email: str, password: str, db: Session) -> User:
    password_hash, salt = hash_password_with_random_salt(password)
    user = User(email=email, password_hash=password_hash, salt=salt)
    storage_interface.create_user(user, db)
    print(f"created user {email} in DB")
    return user


def user_generate_token(user: User, db: Session) -> None:
    uuid = str(uuid4())
    user.current_token = uuid
    user.token_expiry = time.time() + 3600
    update_user(user, db=db)


async def get_current_user(
    header_token: Annotated[str, Depends(OAuth2PasswordBearer(tokenUrl="api/token", auto_error=False))],
    query_token: Annotated[str, Depends(APIKeyQuery(name="user_token", auto_error=False))],
    db: Annotated[str, Depends(get_db)],
) -> User:
    logger.info(f"checking authorization header token {header_token}")
    user = get_user_for_token(header_token, db=db)
    if not user and query_token:
        logger.info(f"checking for query parameter user token {query_token}")
        user = get_user_for_token(query_token, db=db)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return user
