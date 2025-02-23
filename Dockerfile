# Node.js와 Python이 포함된 컨테이너 이미지 사용
FROM mcr.microsoft.com/devcontainers/javascript-node:20

# 작업 디렉토리 설정
WORKDIR /workspace

# 개발 환경 기본 패키지 설치
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Node.js 패키지 설치 (필요하면)
# COPY frontend/package.json frontend/package-lock.json /workspace/frontend/
# RUN cd frontend && npm install

# FastAPI 백엔드 패키지 설치
# COPY backend/requirements.txt /workspace/backend/
# RUN pip install -r backend/requirements.txt

# 기본 명령어 설정 (컨테이너가 실행될 때 bash 환경 유지)
CMD [ "sleep", "infinity" ]
