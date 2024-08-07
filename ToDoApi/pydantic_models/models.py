from pydantic import BaseModel
from datetime import datetime

class User(BaseModel):
    login: str
    password: str


class AccessRefreshTokensAnswer(BaseModel):
    access_token: str
    refresh_token: str


class RefreshTokenRequest(BaseModel):
    refresh_token: str


class AccessTokenResponse(BaseModel):
    access_token: str


class AccessTokenRequest(BaseModel):
    access_token: str

class RecordAnswer(BaseModel):
    record_id: str
    record_text: str
    last_update: datetime

class RecordAnswerAccess(BaseModel):
    record_id: str
    record_owner_id: str
    record_text: str
    last_update: datetime
    access_rights: str


class RecordRequest(BaseModel):
    access_token: str
    record_text: str

class GiveAccess(BaseModel):
    access_token: str
    record_access_id: str
    user_access_login: str
    access_rights: str


class DeleteAccess(BaseModel):
    access_token: str
    user_access_login: str
    record_access_id: str