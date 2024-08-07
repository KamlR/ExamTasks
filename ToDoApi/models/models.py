import datetime
import uuid

from sqlalchemy import MetaData, Integer, String, Table, Column, Text, TIMESTAMP
from sqlalchemy.dialects.postgresql import UUID

metadata = MetaData()

users = Table(
    "users",
    metadata,
    Column("user_id", UUID(as_uuid=True), primary_key=True, default=uuid.uuid4),
    Column("login", String, nullable=False),
    Column("hashed_password", String, nullable=False)
)

records = Table(
    "records",
    metadata,
    Column("record_id", UUID(as_uuid=True), primary_key=True, default=uuid.uuid4),
    Column("record_owner_id", UUID(as_uuid=True), nullable=False),
    Column("record", Text, nullable=False),
    Column("last_update", TIMESTAMP, default=datetime.datetime.utcnow, nullable=False)
)

records_access = Table(
    "records_access",
    metadata,
    Column("record_id", UUID(as_uuid=True), nullable=False),
    Column("record_owner_id", UUID(as_uuid=True), nullable=False),
    Column("user_access_id", UUID(as_uuid=True), nullable=False),
    Column("rights", String, nullable=False)
)
