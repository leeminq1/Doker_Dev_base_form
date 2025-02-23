# 🚀 Vue + FastAPI + NginX Dockerized Project

이 프로젝트는 **Vue (Frontend), FastAPI (Backend), NginX (Reverse Proxy)** 를 포함한 **Docker 기반 개발 및 배포 환경**입니다.  
개발 모드에서는 Vue CLI (`npm run serve`)를 사용하고,  
배포 모드에서는 Vue를 `build`한 후 Express로 정적 파일을 서빙합니다.

---

## 📁 프로젝트 구조
```
/my-project
│── frontend/        # Vue.js (프론트엔드)
│   ├── src/         # Vue 컴포넌트 폴더
│   ├── package.json # Vue 패키지 정보
│   ├── server.js    # Express 정적 파일 서빙 (배포용)
│   ├── Dockerfile.dev   # 개발용 Dockerfile
│   ├── Dockerfile.prod  # 배포용 Dockerfile
│   ├── .devcontainer/   # VS Code 컨테이너 개발 설정
│   │   └── devcontainer.json
│── backend/         # FastAPI (백엔드)
│   ├── app/         # FastAPI 코드 폴더
│   ├── requirements.txt # FastAPI 패키지 목록
│   ├── Dockerfile   # FastAPI 컨테이너 설정
│   ├── .devcontainer/  # VS Code 컨테이너 개발 설정
│   │   └── devcontainer.json
│── nginx/           # NginX 설정 파일
│   ├── nginx.conf   # NginX 설정
│   ├── Dockerfile   # NginX 컨테이너 설정
│── docker-compose.dev.yml  # 개발 환경용 Docker Compose 파일
│── docker-compose.prod.yml # 배포 환경용 Docker Compose 파일
```

---

## 🛠️ **설치 방법**
### 1️⃣ **Docker & Docker Compose 설치**
Docker가 설치되어 있어야 합니다.  
[공식 문서](https://docs.docker.com/get-docker/)를 참고하여 Docker를 설치하세요.

### 2️⃣ **프로젝트 클론**
```bash
git clone https://github.com/your-username/my-project.git
cd my-project
```

---

## 🚀 **개발 환경 (Development)**
- 위의 구조대로 만들어 놓고 vue의 경우 frontend 폴더에 들어가서 vue create . 으로 프로젝트를 만들고 수행해야함.
- Vue는 `npm run serve`로 실행 (`8080` 포트)
- FastAPI는 `uvicorn`으로 실행 (`8000` 포트)
- NginX가 80번 포트에서 Reverse Proxy 역할 수행

### ✅ **개발 환경 실행**
```bash
docker-compose -f docker-compose.dev.yml up -d --build
```

### ✅ **VS Code에서 컨테이너 개발**
1. `Ctrl + Shift + P` → `Remote-Containers: Open Folder in Container`
2. `frontend/` 또는 `backend/` 선택 후 개발 시작

---

## 📦 **배포 환경 (Production)**
- Vue를 `npm run build`로 정적 파일 생성 (`dist/`)
- Express (`server.js`)가 `dist/`를 정적 파일로 서빙 (`8000` 포트)
- FastAPI는 `8080` 포트에서 실행
- NginX가 80번 포트에서 요청을 프록시

### ✅ **배포 환경 실행**
```bash
docker-compose -f docker-compose.prod.yml up -d --build
```

---

## 🔥 **개발 & 배포 명령어 정리**
| 환경  | 실행 명령어 | 설명 |
|--------|------------------|----------------------|
| **개발 모드** | `docker-compose -f docker-compose.dev.yml up -d --build` | HMR 지원 (`npm run serve`) |
| **배포 모드** | `docker-compose -f docker-compose.prod.yml up -d --build` | Vue 빌드 후 Express로 서빙 |
| **개발 컨테이너 접속** | `docker exec -it vue-frontend-dev sh` | Vue 컨테이너 내부 접근 |
| **배포 컨테이너 접속** | `docker exec -it vue-frontend-prod sh` | Vue 컨테이너 내부 접근 |
| **모든 컨테이너 종료** | `docker-compose down` | 실행 중인 컨테이너 중지 |

---

## 📜 **NginX 설정 (`nginx/nginx.conf`)**
```nginx
worker_processes 1;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    sendfile on;

    upstream frontend {
        server frontend:8000;
    }

    upstream backend {
        server backend:8080;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://frontend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location /api/ {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
```
➡ `80번 포트`에서 Vue 정적 파일과 FastAPI API 요청을 프록시 처리

---

## 🏗️ **배포 시 Vue Express 정적 파일 서빙**
### 📌 **Vue 배포용 `server.js` (`frontend/server.js`)**
```javascript
const express = require("express");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 8000;

// Vue 빌드된 정적 파일 서빙
app.use(express.static(path.join(__dirname, "dist")));

app.get("*", (req, res) => {
    res.sendFile(path.join(__dirname, "dist", "index.html"));
});

app.listen(PORT, () => {
    console.log(`🚀 Vue app is running at http://localhost:${PORT}`);
});
```
➡ 배포 시 `dist/` 내부의 정적 파일을 Express로 서빙

---

## 🔗 **관련 문서**
- [Docker 공식 문서](https://docs.docker.com/)
- [Vue.js 공식 문서](https://cli.vuejs.org/)
- [FastAPI 공식 문서](https://fastapi.tiangolo.com/)
- [NginX 공식 문서](https://nginx.org/)

---

## 🏁 **마무리**
이제 **개발 환경과 배포 환경을 완전히 분리하여** 컨테이너에서 실행할 수 있습니다! 🚀  
GitHub에 업로드 후 협업할 때도 **개발자는 `npm run serve`, 배포는 Express를 통한 정적 파일 서빙**을 사용할 수 있습니다.
