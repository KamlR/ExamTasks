from fastapi import APIRouter
from pydantic_models.models import AccessTokenRequest, RecordAnswer, RecordRequest
from app.work_with_tokens.tokens import verify_token
from database.database import database
from datetime import datetime


router_records = APIRouter()


@router_records.get("/records/get_all", response_model=list[RecordAnswer])
async def get_all_tasks(access_token: str):
    user_id = verify_token(access_token)
    query = "SELECT * FROM RECORDS WHERE record_owner_id = :record_owner_id"
    tasks = await database.fetch_all(query=query, values={"record_owner_id": user_id})
    return [RecordAnswer(record_id=str(task["record_id"]), record_text=task["record"], last_update=task["last_update"]) for task in tasks]


@router_records.post("/records/create_new_task")
async def create_new_task(request: RecordRequest):
    user_id = verify_token(request.access_token)
    query = "INSERT INTO records (record_owner_id, record) VALUES (:record_owner_id, :record)"
    await database.execute(query=query, values={"record_owner_id": user_id, "record": request.record_text})


@router_records.delete("/records/delete_task")
async def delete_task(access_token: str, record_id: str):
    verify_token(access_token)
    query_delete = "DELETE FROM records WHERE record_id = :record_id"
    await database.execute(query=query_delete, values={"record_id": record_id})


@router_records.put("/records/update_record")
async def update_record(request: RecordRequest, record_id):
    verify_token(request.access_token)
    query_update = """
            UPDATE records 
            SET record = :record_text, last_update = :last_update 
            WHERE record_id = :record_id
        """
    await database.execute(query=query_update, values={"record_text": request.record_text, "last_update": datetime.utcnow(), "record_id": record_id})






