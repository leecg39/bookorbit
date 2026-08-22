# 참조

이 Hostinger 설치의 사실만 적습니다. 제품 전체 API는 [bookorbit.app](https://bookorbit.app/what-is-bookorbit)에 있습니다.

## URL

| 용도        | URL                                       |
| ----------- | ----------------------------------------- |
| 공개 앱     | https://books.soverin.cloud               |
| 헬스        | https://books.soverin.cloud/api/v1/health |
| 대체 호스트 | https://bookorbit.srv1655088.hstgr.cloud  |
| 최초 마법사 | https://books.soverin.cloud/setup         |
| 로그인      | https://books.soverin.cloud/login         |

## 호스트

| 항목         | 값                       |
| ------------ | ------------------------ |
| VPS 호스트명 | `srv1655088`             |
| 공인 IPv4    | `72.61.116.250`          |
| SSH (이 Mac) | `ssh hostinger-vps`      |
| 키 파일      | `~/.ssh/hostinger_codex` |

## Docker

| 항목                | 값                                                      |
| ------------------- | ------------------------------------------------------- |
| 프로젝트 디렉터리   | `/docker/bookorbit`                                     |
| Compose 파일        | `/docker/bookorbit/docker-compose.yml`                  |
| 앱 컨테이너         | `bookorbit-app`                                         |
| DB 컨테이너         | `bookorbit-db`                                          |
| 앱 이미지 환경 변수 | `APP_IMAGE` (기본 `ghcr.io/bookorbit/bookorbit:latest`) |
| DB 이미지           | `pgvector/pgvector:pg18`                                |
| Docker 네트워크     | `bookorbit_default`                                     |
| 호스트 공개 포트    | 없음 (Traefik만)                                        |
| 컨테이너 리슨       | `3000`                                                  |

Traefik 라우터: `Host(books.soverin.cloud)`와 `Host(bookorbit.srv1655088.hstgr.cloud)`, 엔트리포인트 `websecure`, certresolver `letsencrypt`.

## 바인드 마운트

| 호스트                            | 컨테이너                   |
| --------------------------------- | -------------------------- |
| `/docker/bookorbit/books`         | `/books`                   |
| `/docker/bookorbit/data/app`      | `/data`                    |
| `/docker/bookorbit/data/postgres` | `/var/lib/postgresql/data` |

## 환경 변수 (이름만)

이 호스트에서 필수 (값은 `/docker/bookorbit/.env`에만, 여기에는 없음):

- `APP_IMAGE`, `APP_URL`, `CLIENT_URL`
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- `JWT_SECRET`, `SETUP_BOOTSTRAP_TOKEN`
- `BOOKS_HOST_PATH`, `PUID`, `PGID`, `LIBRARY_BROWSE_ROOT`

`APP_URL`과 `CLIENT_URL`은 `https://books.soverin.cloud`입니다.

프로덕션에서 `/auth/setup`은 `SETUP_BOOTSTRAP_TOKEN`이 필요합니다 (`x-setup-token` 헤더). 최초 관리자가 생긴 뒤 일상 로그인에는 쓰지 않습니다.

## 주요 UI 경로

| 영역          | 경로                    |
| ------------- | ----------------------- |
| 홈            | `/`                     |
| 도서관        | `/libraries`            |
| 책            | `/book/:bookId`         |
| 리더          | `/read/:bookId/:fileId` |
| 주석          | `/annotations`          |
| 통계          | `/statistics`           |
| 업적          | `/achievements`         |
| 컬렉션        | `/collections`          |
| 스마트 스코프 | `/smart-scopes`         |
| 저자 / 시리즈 | `/authors`, `/series`   |
| 도구          | `/tools`                |
| Kobo          | `/settings/kobo`        |
| KOReader      | `/settings/koreader`    |
| OPDS          | `/settings/opds`        |
| 사용자        | `/settings/admin/users` |

## Cloudflare DNS

| 타입 | 이름    | 내용            | 프록시  |
| ---- | ------- | --------------- | ------- |
| A    | `books` | `72.61.116.250` | Proxied |

## 관련

- [운영](05-operations.md)
- [문제 해결](07-troubleshooting.md)
- 공식 설치: [bookorbit.app/installation](https://bookorbit.app/installation)
