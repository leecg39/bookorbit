# 이 BookOrbit 호스트를 운영하는 방법

컨테이너 업데이트, 로그, 백업, DNS와 Traefik 확인. Mac에서 `ssh hostinger-vps` (`root@72.61.116.250`)를 가정합니다.

## 준비

- SSH 키 `~/.ssh/hostinger_codex`, 호스트 별칭 `hostinger-vps`
- smb, botanic, supabase, Traefik 등 다른 스택은 의도 없이 중지하지 말 것

## VPS 배치

| 항목             | 경로 또는 이름                                            |
| ---------------- | --------------------------------------------------------- |
| Compose 프로젝트 | `/docker/bookorbit`                                       |
| 환경 파일        | `/docker/bookorbit/.env` (권한 600)                       |
| 책 파일          | `/docker/bookorbit/books`                                 |
| 앱 데이터        | `/docker/bookorbit/data/app`                              |
| Postgres 데이터  | `/docker/bookorbit/data/postgres`                         |
| 컨테이너         | `bookorbit-app`, `bookorbit-db`                           |
| 프록시           | 기존 `traefik-traefik-1` (호스트 네트워크, Let's Encrypt) |

## 상태

```bash
ssh hostinger-vps 'docker ps --filter name=bookorbit; curl -fsS https://books.soverin.cloud/api/v1/health'
```

정상 JSON은 `"status":"ok"`와 DB `"up"`입니다.

## 로그

```bash
ssh hostinger-vps 'docker logs --tail 200 bookorbit-app'
ssh hostinger-vps 'docker logs --tail 100 bookorbit-db'
ssh hostinger-vps 'docker logs --since 10m traefik-traefik-1'
```

## GitHub

VPS 경로 `/docker/bookorbit`는 private 저장소 [leecg39/bookorbit](https://github.com/leecg39/bookorbit)를 따라갑니다. `.env`, `books/`, `data/`는 서버에만 있고 git에 없습니다.

`main`에 푸시하면 GitHub Actions가 SSH로 배포합니다. 수동 배포:

```bash
ssh hostinger-vps 'bash /docker/bookorbit/deploy/hostinger/deploy.sh'
```

배포 후 주소: https://books.soverin.cloud 와 https://bookorbit.srv1655088.hstgr.cloud

## 앱 이미지 업데이트

이 호스트는 `APP_IMAGE=ghcr.io/bookorbit/bookorbit:latest`를 씁니다.

```bash
ssh hostinger-vps 'cd /docker/bookorbit && docker compose pull && docker compose up -d'
```

헬스 확인:

```bash
ssh hostinger-vps 'docker ps --filter name=bookorbit-app'
```

`latest`를 원하지 않으면 `.env`에서 버전을 고정합니다 ([참조](06-reference.md)).

## 재시작

```bash
ssh hostinger-vps 'cd /docker/bookorbit && docker compose restart'
```

## 백업

Postgres 디렉터리를 일관되게 복사하려면 중지가 더 안전합니다.

```bash
ssh hostinger-vps 'cd /docker/bookorbit && docker compose stop'
# /docker/bookorbit/data 와 /docker/bookorbit/books 를 밖으로 복사
ssh hostinger-vps 'cd /docker/bookorbit && docker compose start'
```

`.env`는 비밀 저장소에 두고 git에 넣지 마세요.

이 VPS 디스크는 다른 스택과 공유됩니다. 큰 복사 전에:

```bash
ssh hostinger-vps 'df -h /'
```

## DNS와 TLS

Cloudflare 존 `soverin.cloud`:

- 타입 A, 이름 `books`, 내용 `72.61.116.250`, **Proxied** (`smb.soverin.cloud`와 동일)

Traefik 라벨은 `bookorbit.srv1655088.hstgr.cloud`도 받습니다. 사용자와 장치에는 `books.soverin.cloud`를 쓰세요.

## 하지 말 것

- 호스트 3000번을 열지 마세요. Open WebUI가 이미 `127.0.0.1:3000`을 씁니다. Traefik은 Docker 네트워크로 앱에 붙습니다.
- 볼륨을 지울 생각이 아니면 `docker compose down -v`를 하지 마세요.
- 다른 프로젝트를 확인하지 않고 이미지 전체를 prune하지 마세요.

## 확인

- `https://books.soverin.cloud/api/v1/health`가 200
- `docker inspect bookorbit-app --format '{{.State.Health.Status}}'`가 `healthy`

## 문제 해결

업데이트 후 헬스가 실패하면 [문제 해결](07-troubleshooting.md)을 보세요.
