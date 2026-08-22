# 도서관과 책을 다루는 방법

도서관을 만들고, 폴더를 스캔하고, 파일을 가져오고, 메타데이터를 고칩니다. 이 인스턴스는 개인 도서관이 수만 권이어도 브라우저에 전체를 한 번에 올리지 않도록 설계되어 있습니다.

## 준비

- 도서관을 만들고 스캔할 수 있는 관리자 또는 역할
- VPS `/docker/bookorbit/books` 아래 파일, 또는 UI 업로드
- https://books.soverin.cloud 로그인

## 도서관 만들기

1. **도서관(Libraries)** 을 엽니다.
2. 도서관을 만들고 이름을 짓습니다.
3. 폴더는 `/books` 아래 경로로 고릅니다 (호스트 `/docker/bookorbit/books`). 컨테이너 루트 `/`를 고르지 마세요.
4. 같은 제목에 포맷이 여러 개면 스캔 규칙과 포맷 우선순위를 정합니다 (EPUB, KEPUB, PDF 등).
5. 저장한 뒤 스캔을 돌립니다.

이 호스트는 `LIBRARY_BROWSE_ROOT=/books`라서 폴더 선택이 `/books`부터 시작합니다.

## 파일 넣기

디스크에 이미 트리가 있으면 **서버에 복사**:

```bash
ssh hostinger-vps
# /docker/bookorbit/books/... 로 복사
```

Mac에서:

```bash
scp -r /path/to/books hostinger-vps:/docker/bookorbit/books/
```

몇 권만 넣을 때는 브라우저 **끌어다 놓기**로 업로드합니다.

손 안 대고 넣으려면 **Book Dock**: **설정 > 시스템 / Book Dock** (`/settings/admin/book-dock`). 지정한 드롭 폴더에 파일을 두면 매번 수동 스캔 없이 가져옵니다.

## 스캔과 메타데이터

1. 파일이 들어가면 도서관 페이지에서 스캔을 시작합니다.
2. 진행을 기다립니다. 수만 권은 배치로 스캔되며, 한 응답에 전체 목록이 오지 않습니다.
3. 책을 열고 제목이나 표지가 틀리면 메타데이터를 새로고침합니다.
4. 제공자는 **설정 > 메타데이터 > 제공자** (Google Books, Open Library, Amazon, Goodreads, Kobo, Hardcover, Audible, 알라딘 등).
5. 필드 규칙, 커스텀 필드, 자동 가져오기, 저자, 장르 차단은 **설정 > 메타데이터** 아래에 있습니다.

한국어 목록은 **알라딘** 제공자를 켜면 쓸 수 있습니다.

## 정리

- **컬렉션**: 직접 고른 목록 (`/collections`)
- **스마트 스코프**: 규칙 기반 저장 필터 (`/smart-scopes`)
- **저자**와 **시리즈**: `/authors`, `/series`
- **도구**: 엔티티 관리, 일괄 이름 변경, 중복 책 (`/tools`)

한 권 편집은 `/book/:id/edit`. 파일 관리는 `/book/:id/files`.

## 확인

- 스캔이 끝나면 홈 또는 도서관 페이지에 제목이 보입니다.
- 책을 열면 표지와 메타데이터가 있습니다.
- 복사한 파일이 고른 도서관 폴더 아래에 있습니다.

## 문제 해결

- 복사 후에도 비어 있음: 파일이 `/docker/bookorbit/books` 아래인지, 도서관 폴더가 `/books` 안 그 경로와 맞는지 확인합니다.
- 스캔 권한 오류: 호스트 UID/GID가 `/docker/bookorbit/.env`의 `PUID`/`PGID`와 같아야 합니다 (기본 `1000`/`1000`).
- 스캔이 멈춘 것 같음: [운영](05-operations.md)의 `docker logs bookorbit-app`을 봅니다.

[문제 해결](07-troubleshooting.md)도 참고하세요.
