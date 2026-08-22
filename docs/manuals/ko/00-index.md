# BookOrbit 매뉴얼 (한국어)

이 문서는 **https://books.soverin.cloud** 인스턴스 기준입니다.

웹 UI는 **설정 > 모양 > 언어**에서 한국어로 바꿀 수 있습니다. 영문 매뉴얼은 [../en/](../en/00-index.md)에 있습니다.

## 무엇을 읽을지

| 하고 싶은 일                                   | 시작 문서                                    |
| ---------------------------------------------- | -------------------------------------------- |
| 사이트 열기, 최초 관리자 만들기, 첫 책 넣기    | [시작하기](01-getting-started.md)            |
| 도서관 만들기, 폴더 스캔, 가져오기, 메타데이터 | [도서관과 책](02-libraries-and-books.md)     |
| 웹 리더, Kobo, KOReader, OPDS                  | [읽기와 장치 동기화](03-reading-and-sync.md) |
| 사용자, 권한, SSO, 이메일                      | [사용자와 관리](04-users-and-admin.md)       |
| Docker 업데이트, 백업, 로그, DNS               | [운영](05-operations.md)                     |
| 경로, URL, 환경 변수, compose 구조             | [참조](06-reference.md)                      |
| 로그인, 토큰, 스캔, HTTPS 오류                 | [문제 해결](07-troubleshooting.md)           |

## 이 인스턴스

BookOrbit은 전자책, PDF, 만화, 오디오북을 직접 호스팅하는 도서관입니다. 이 복사본은 Hostinger VPS `srv1655088`에서 Docker 컨테이너 두 개(`bookorbit-app`, `bookorbit-db`)로 돌아가고, Traefik과 Cloudflare가 `books.soverin.cloud`를 프록시합니다.

## 관련

- English manuals: [../en/00-index.md](../en/00-index.md)
- 공식 제품 문서: [bookorbit.app](https://bookorbit.app/what-is-bookorbit)
