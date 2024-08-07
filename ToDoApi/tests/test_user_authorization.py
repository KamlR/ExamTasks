import pytest
from httpx import AsyncClient
from unittest.mock import AsyncMock, patch
from pydantic_models.models import User

from main import app



@pytest.fixture
async def client() -> AsyncClient:
    async with AsyncClient(app=app, base_url="http://test") as client:
        yield client

@pytest.mark.asyncio
@patch("database.database.database.fetch_one")
@patch("app.reg_auth.reg_auth.verify_password")
@patch("app.reg_auth.reg_auth.get_tokens")
async def test_authorization_success(mock_get_tokens: AsyncMock, mock_verify_password: AsyncMock, mock_fetch_one: AsyncMock, client: AsyncClient):
    mock_fetch_one.return_value = {"user_id": 1, "hashed_password": "hashed_password123"}
    mock_verify_password.return_value = True
    mock_get_tokens.return_value = {"access_token": "access_token_value", "refresh_token": "refresh_token_value"}

    user = User(login="user1", password="password123")
    response = await client.post("/authorization", json=user.dict())
    assert response.status_code == 200
    data = response.json()
    assert data == {"access_token": "access_token_value", "refresh_token": "refresh_token_value"}
    mock_fetch_one.assert_called_once_with(query="SELECT * FROM users WHERE login = :login", values={"login": "user1"})
    mock_verify_password.assert_called_once_with("hashed_password123", "password123")
    mock_get_tokens.assert_called_once_with("1")

@pytest.mark.asyncio
@patch("database.database.database.fetch_one")
async def test_authorization_incorrect_login(mock_fetch_one: AsyncMock, client: AsyncClient):
    mock_fetch_one.return_value = None

    user = User(login="nonexistentuser", password="password123")
    response = await client.post("/authorization", json=user.dict())
    assert response.status_code == 400
    data = response.json()
    assert data["detail"] == "Incorrect login"
    mock_fetch_one.assert_called_once_with(query="SELECT * FROM users WHERE login = :login", values={"login": "nonexistentuser"})

@pytest.mark.asyncio
@patch("database.database.database.fetch_one")
@patch("app.reg_auth.reg_auth.verify_password")
async def test_authorization_incorrect_password(mock_verify_password: AsyncMock, mock_fetch_one: AsyncMock, client: AsyncClient):
    mock_fetch_one.return_value = {"user_id": 1, "hashed_password": "hashed_password123"}
    mock_verify_password.return_value = False

    user = User(login="user1", password="wrongpassword")
    response = await client.post("/authorization", json=user.dict())
    assert response.status_code == 400
    data = response.json()
    assert data["detail"] == "Incorrect password"
    mock_fetch_one.assert_called_once_with(query="SELECT * FROM users WHERE login = :login", values={"login": "user1"})
    mock_verify_password.assert_called_once_with("hashed_password123", "wrongpassword")
