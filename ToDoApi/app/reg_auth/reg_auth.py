from database.database import database
from fastapi import HTTPException, APIRouter
from pydantic_models.models import User, AccessRefreshTokensAnswer
from passlib.context import CryptContext
from ..work_with_tokens.tokens import get_tokens
import logging
# Настройка базовой конфигурации логирования
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# Создание логгера
logger = logging.getLogger(__name__)



router_registration_authorization = APIRouter()
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


@router_registration_authorization.post("/register", response_model=AccessRefreshTokensAnswer)
async def user_registration(user: User):
    query = "SELECT * FROM users WHERE login = :login"
    db_user = await database.fetch_one(query=query, values={"login": user.login})
    if db_user:
        raise HTTPException(status_code=400, detail="Login already exists")
    hashed_password = get_password_hash(user.password)
    query = "INSERT INTO users (login, hashed_password) VALUES (:login, :hashed_password) RETURNING user_id"
    user_id = await database.execute(query=query, values={"login": user.login, "hashed_password": hashed_password})
    return get_tokens(str(user_id))


@router_registration_authorization.post("/authorization", response_model=AccessRefreshTokensAnswer)
async def authorization(user: User):
    query = "SELECT * FROM users WHERE login = :login"
    db_user = await database.fetch_one(query=query, values={"login": user.login})
    if db_user is None:
        raise HTTPException(status_code=400, detail="Incorrect login")
    if not verify_password(db_user["hashed_password"], user.password):
        raise HTTPException(status_code=400, detail="Incorrect password")
    return get_tokens(str(db_user["user_id"]))


def get_password_hash(password):
    return pwd_context.hash(password)

def verify_password(hashed_password, password):
    return pwd_context.verify(password, hashed_password)