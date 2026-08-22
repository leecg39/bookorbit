# 시작하기

사이트를 열고, 아직이면 최초 관리자 계정을 만들고, 필요하면 언어를 바꾼 뒤, 첫 도서관을 만듭니다.

## 필요한 것

- 브라우저 (Chrome, Safari, Ego 등)
- 주소 **https://books.soverin.cloud**
- 셋업이 아직이면: 서버 `.env`의 프로덕션 셋업 토큰 (이 매뉴얼에는 적지 않음)

## 1단계: 사이트 열기

접속:

https://books.soverin.cloud

대체 호스트 (같은 앱, Hostinger DNS):

https://bookorbit.srv1655088.hstgr.cloud

**Initial setup**, **로그인**, 또는 대시보드가 보여야 합니다.

## 2단계: 최초 관리자 만들기 (한 번만)

**Initial setup** 화면이면:

1. 사용자 이름, 이름, 이메일, 비밀번호 (8자 이상, 대문자·소문자·숫자 포함).
2. VPS `/docker/bookorbit/.env`의 `SETUP_BOOTSTRAP_TOKEN=` 값을 **Setup token**에 붙입니다. 비어 있거나 틀리면 **Invalid setup token**이 납니다.
3. **Create administrator account**를 누릅니다.
4. 그 계정으로 앱에 들어갑니다.

이미 계정을 만들었다면 **로그인**만 하면 됩니다. 셋업을 다시 돌리지 마세요.

토큰 확인 (커밋하지 말 것):

```bash
ssh hostinger-vps 'grep ^SETUP_BOOTSTRAP_TOKEN= /docker/bookorbit/.env'
```

## 3단계: UI 언어 (선택)

1. **설정 > 모양 > 언어**를 엽니다.
2. **한국어** (`ko`) 또는 **영어** (`en`)를 고릅니다.
3. 메뉴는 그 언어를 따릅니다. 한국어 매뉴얼은 이 폴더에 있습니다.

## 4단계: 책 파일 위치

VPS 호스트 폴더가 컨테이너의 `/books`로 붙어 있습니다.

- 호스트: `/docker/bookorbit/books`
- 컨테이너: `/books`

Mac에서 복사 예:

```bash
scp -r ./my-library hostinger-vps:/docker/bookorbit/books/
```

웹 UI 끌어다 넣기로 올려도 됩니다.

그다음 앱에서:

1. **도서관(Libraries)** 을 엽니다.
2. `/books` 아래 폴더를 고른 도서관을 만듭니다.
3. 스캔을 돌려 홈 선반에 제목이 나오게 합니다.

자세한 내용: [도서관과 책](02-libraries-and-books.md).

## 지금까지 한 일

https://books.soverin.cloud 에 관리자로 로그인할 수 있고, 파일은 `/docker/bookorbit/books`에 들어가며, 스캔할 도서관이 하나 준비됩니다.

다음: [도서관과 책](02-libraries-and-books.md) 또는 [읽기와 장치 동기화](03-reading-and-sync.md).
