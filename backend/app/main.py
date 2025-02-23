from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# CORS 설정: Vue 프론트엔드에서 FastAPI 백엔드에 요청을 보낼 수 있도록 허용
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 모든 출처 허용 (배포 환경에서는 특정 도메인만 허용하는 것이 좋음)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 기본 API 엔드포인트
@app.get("/")
async def root():
    return {"message": "Hello from FastAPI"}

# Vue에서 호출할 API 엔드포인트
@app.get("/api/data")
async def get_data():
    return {"data": "This is data from FastAPI"}
