# 문제 해결

**https://books.soverin.cloud** 와 이 VPS에서 자주 나는 오류입니다.

## Invalid setup token

**증상:** 최초 설정 화면에 빨간 **Invalid setup token** (`POST /api/v1/auth/setup`가 403).

**원인:** 프로덕션은 `x-setup-token`을 `SETUP_BOOTSTRAP_TOKEN`과 비교합니다. 칸이 비어 있거나 오타면 실패합니다.

**해결:**

```bash
ssh hostinger-vps 'grep ^SETUP_BOOTSTRAP_TOKEN= /docker/bookorbit/.env'
```

값을 **Setup token**에 붙입니다. 비밀번호는 여전히 8자 이상, 대문자·소문자·숫자가 필요합니다.

최초 관리자가 생긴 뒤에는 셋업이 아니라 **로그인**을 씁니다.

## 사이트가 안 열림 (DNS 또는 TLS)

**증상:** NXDOMAIN, SSL 오류, 시간 초과.

**확인:**

```bash
dig +short A books.soverin.cloud
curl -fsS -o /dev/null -w '%{http_code}\n' https://books.soverin.cloud/api/v1/health
ssh hostinger-vps 'docker logs --since 15m traefik-traefik-1 | grep -i books.soverin || true'
```

Cloudflare에 A `books` -> `72.61.116.250` Proxied가 있어야 합니다. 대체: https://bookorbit.srv1655088.hstgr.cloud

## 헬스가 죽거나 앱이 재시작

```bash
ssh hostinger-vps 'docker ps -a --filter name=bookorbit; docker logs --tail 80 bookorbit-app'
```

앱이 유지되려면 Postgres가 healthy여야 합니다. 디스크 가득 참(`df -h /`)도 쓰기를 막습니다.

## 파일 복사 후 도서관이 비어 있음

- 파일은 `/docker/bookorbit/books` 아래여야 합니다
- UI 도서관 폴더는 `/books` 아래여야 합니다
- 복사 후 스캔을 돌리세요
- `.env`의 `PUID`/`PGID`가 그 폴더 소유자와 같아야 합니다

## Kobo 또는 KOReader가 안 붙음

- 장치 URL은 `https://books.soverin.cloud`여야 하고 3000번 포트가 아닙니다
- URL이 바뀌었으면 KOReader 플러그인을 다시 받으세요
- `books` Cloudflare 프록시는 `smb`처럼 켜 두세요

## 관리 동작이 403

API가 권한을 강제합니다. 권한이 없으면 URL을 알아도 설정 페이지를 쓸 수 없습니다. 슈퍼유저를 쓰거나 권한을 주세요.

## 로그인 루프 또는 쿠키

`books.soverin.cloud`의 HTTPS를 쓰세요. hstgr 호스트와 Cloudflare 호스트를 한 세션에서 섞으면 쿠키가 꼬일 수 있습니다. 호스트 하나를 고르고 유지하세요.

## 그래도 안 되면

모아 둘 것:

- 브라우저 URL과 상태 코드
- `docker logs --tail 100 bookorbit-app` (채팅에 `.env` 내용은 넣지 말 것)
- 요청 시각 (UTC 또는 KST)

그다음 [운영](05-operations.md)과 [참조](06-reference.md)를 보세요.
