# Python 3.11 사용
FROM python:3.11

# 작업 디렉토리 설정
WORKDIR /app

# FastAPI 및 필요한 패키지 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# FastAPI 애플리케이션 코드 복사
# ✅ `app` 폴더 내부의 코드를 컨테이너 내부로 복사
COPY ./app /app 

# FastAPI 실행
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080", "--reload"]
