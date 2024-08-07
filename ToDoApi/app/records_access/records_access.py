from fastapi import APIRouter, HTTPException
from app.work_with_tokens.tokens import verify_token
from database.database import database
from pydantic_models.models import RecordAnswerAccess, GiveAccess, DeleteAccess, RecordRequest
from datetime import datetime

router_records_access = APIRouter()

@router_records_access.get("/records_access/getall")
async def get_all(access_token: str):
    user_id = verify_token(access_token)
    query = """
            SELECT * FROM records r
            JOIN records_access ra ON r.record_id = ra.record_id AND r.record_owner_id = ra.record_owner_id
            WHERE ra.user_access_id = :user_access_id
        """
    records = await database.fetch_all(query=query, values={"user_access_id": user_id})
    return [RecordAnswerAccess(record_owner_id = str(record["record_owner_id"]), record_id=str(record["record_id"]), record_text=record["record"], last_update=record["last_update"],
                               access_rights = record["rights"])
            for record in records]


@router_records_access.post("/records_access/give_access")
async def give_access_to_record(request: GiveAccess):
    record_owner_id = verify_token(request.access_token)
    user_access_id = await get_userid_by_login(request.user_access_login)
    query = "INSERT INTO records_access (record_id, record_owner_id, user_access_id, rights) VALUES (:record_id, :record_owner_id, :user_access_id, :rights)"
    await database.execute(query=query, values={"record_id": request.record_access_id, "record_owner_id": record_owner_id,
                                                "user_access_id": user_access_id, "rights": request.access_rights})


@router_records_access.delete("/records_access/delete_access")
async def delete_access_to_record(request: DeleteAccess):
    record_owner_id = verify_token(request.access_token)
    user_access_id = await get_userid_by_login(request.user_access_login)
    query = """
            DELETE FROM records_access
            WHERE record_owner_id = :record_owner_id AND user_access_id = :user_access_id
            AND record_id = :record_id
        """
    await database.execute(query=query, values={"record_owner_id": record_owner_id, "user_access_id": user_access_id,
                                                 "record_id": request.record_access_id})


@router_records_access.put("/records_access/update_record")
async def update_record(request: RecordRequest, record_id):
    verify_token(request.access_token)
    query_update = """
            UPDATE records 
            SET record = :record_text, last_update = :last_update 
            WHERE record_id = :record_id
        """
    await database.execute(query=query_update, values={"record_text": request.record_text, "last_update": datetime.utcnow(), "record_id": record_id})



async def get_userid_by_login(login: str):
    query = "SELECT user_id FROM users WHERE login = :login"
    db_user = await database.fetch_one(query=query, values={"login": login})
    if db_user is None:
        raise HTTPException(status_code=400, detail="There is no user with such login")
    return str(db_user["user_id"])




