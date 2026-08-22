# 읽고 장치를 동기화하는 방법

웹 리더로 읽은 뒤 Kobo, KOReader, OPDS 앱을 붙여 진행률과 하이라이트가 따라오게 합니다.

## 준비

- 도서관에 책이 한 권이라도 있을 것
- Kobo: 사용자 지정 동기화 URL을 쓸 수 있는 기기
- KOReader: KOReader가 설치된 기기
- 이 인스턴스 공개 URL: **https://books.soverin.cloud** (장치 URL에는 Hostinger 호스트 대신 이것을 쓰세요)

## 웹 리더

1. 홈 선반이나 도서관에서 책을 엽니다.
2. 리더로 들어갑니다 (`/read/:bookId/:fileId`).
3. EPUB, KEPUB, MOBI, AZW3, PDF, CBZ/CBR/CB7, 흔한 오디오북(M4B, MP3 등)을 지원합니다.
4. 웹 리더 하이라이트와 메모는 **주석(Annotations)** (`/annotations`)에 모입니다.
5. 리더 기본값: **설정 > 리더** (전자책, PDF, 만화, 오디오, 글꼴).

## Kobo 동기화

1. **설정 > Kobo** (`/settings/kobo`)를 엽니다.
2. 펌웨어에 맞는 페어링을 따릅니다. 동기화 주소는 `https://books.soverin.cloud`여야 합니다.
3. 페어링 후 도서관에서 기기로 책을 보냅니다.
4. Kobo 동기화가 정상이면 진행률, 하이라이트, 삭제가 웹 리더와 양방향으로 맞습니다.

기기가 서버에 못 가면 Cloudflare 프록시와 Traefik을 확인하세요 ([운영](05-operations.md)). Kobo를 `http://`나 공개 3000번 포트 IP로 두지 마세요. 이 설치는 앱 3000번을 인터넷에 열지 않습니다.

## KOReader 플러그인

1. **설정 > KOReader** (`/settings/koreader`)를 엽니다.
2. 요청되면 자격 증명을 만듭니다.
3. **Download Plugin**을 누릅니다. zip에 이 서버 URL이 미리 들어 있습니다.
4. `bookorbit.koplugin.zip`을 풉니다.
5. `bookorbit.koplugin`을 기기의 `koreader/plugins/`로 복사합니다.
6. KOReader를 다시 시작하고 책을 연 뒤 **Tools > BookOrbit Sync**.

목록 탐색, 검색, 다운로드, 진행률 동기화, 양방향 주석을 씁니다.

공식 설명: [bookorbit.app/koreader-plugin](https://bookorbit.app/koreader-plugin).

## OPDS와 Send-to-Kindle

- **OPDS**: **설정 > OPDS** (`/settings/opds`). 화면에 나온 OPDS URL을 호환 앱에 넣습니다 (`books.soverin.cloud` HTTPS).
- **Send-to-Kindle**: **설정 > 이메일**에서 SMTP를 맞춘 뒤 책에서 보내기 동작을 씁니다.

## 읽기 통계

- **통계** (`/statistics`): 시간, 히트맵, 연속 기록
- **업적** (`/achievements`)
- 선택 연동: **설정 > Hardcover**, **Readwise**, **StoryGraph**

## 확인

- 브라우저 리더에서 책이 열립니다.
- Kobo 또는 KOReader 설정 후 동기화가 끝나면 기기 진행률이 BookOrbit에 보이거나 그 반대입니다.
- OPDS 클라이언트가 HTTPS로 목록을 받습니다.

## 문제 해결

- 기기 접속 실패: `books.soverin.cloud` DNS(Cloudflare)와 Traefik Host `books.soverin.cloud`를 확인합니다.
- 플러그인 zip 호스트가 틀림: 이 호스트의 `APP_URL`은 이미 `https://books.soverin.cloud`입니다. 플러그인을 다시 받습니다.
- 하이라이트가 없음: **주석**을 보고, 파일만 복사한 게 아니라 양쪽 동기화가 끝났는지 확인합니다.

[문제 해결](07-troubleshooting.md)을 보세요.
