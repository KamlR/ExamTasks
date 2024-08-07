from fastapi import FastAPI
from database.database import connect_to_db, disconnect_from_db
from app.reg_auth.reg_auth import router_registration_authorization
from app.work_with_tokens.tokens import router_tokens
from app.records.records import router_records
from app.records_access.records_access import router_records_access

app = FastAPI()
app.include_router(router_registration_authorization)
app.include_router(router_tokens)
app.include_router(router_records)
app.include_router(router_records_access)


# Подключение к бд
@app.on_event("startup")
async def startup():
    await connect_to_db()


# Отключение от бд
@app.on_event("shutdown")
async def shutdown():
    await disconnect_from_db()





