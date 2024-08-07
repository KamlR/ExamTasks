import pytest_asyncio, pytest
from httpx import AsyncClient
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from unittest.mock import AsyncMock, patch
from pydantic_models.models import User, AccessRefreshTokensAnswer

from main import app
from app.reg_auth.reg_auth import router_registration_authorization


def get_password_hash(password: str) -> str:
    return "hashed_" + password



@pytest_asyncio.fixture
async def client() -> AsyncClient:
    async with AsyncClient(app=app, base_url="http://test") as client:
        yield client


@pytest.mark.asyncio
@patch("database.database.database.fetch_one")
@patch("database.database.database.execute")
@patch("app.reg_auth.reg_auth.get_password_hash",  return_value="hashed_password123")
async def test_register_success(mock_execute: AsyncMock, mock_fetch_one: AsyncMock, client: AsyncClient):
    mock_fetch_one.return_value = None
    mock_execute.return_value = 1

    user = User(login="user1", password="password123")
    response = await client.post("/register", json=user.dict())
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data
    mock_fetch_one.assert_called_once_with(query="SELECT * FROM users WHERE login = :login", values={"login": "user1"})
    mock_execute.assert_called_once_with(query="INSERT INTO users (login, hashed_password) VALUES (:login, :hashed_password) RETURNING user_id",
                                         values={"login": "user1", "hashed_password": "hashed_password123"})


@pytest.mark.asyncio
@patch("database.database.database.fetch_one")
async def test_register_user_already_exists(mock_fetch_one: AsyncMock, client: AsyncClient):
    mock_fetch_one.return_value = {"login": "existinguser", "hashed_password": "hashed_password123"}

    user = User(login="existinguser", password="password123")
    response = await client.post("/register", json=user.dict())
    assert response.status_code == 400
    data = response.json()
    assert data["detail"] == "Login already exists"
    mock_fetch_one.assert_called_once_with(query="SELECT * FROM users WHERE login = :login", values={"login": "existinguser"})