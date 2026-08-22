# 사용자와 관리

사람을 추가하고 권한을 정합니다. 관리 도구는 서버에서 검사합니다. 이 앱은 다중 사용자이고, 사용자 데이터는 `userId`로 구분됩니다.

## 준비

- 최초 관리자 계정이 있을 것 ([시작하기](01-getting-started.md))
- **설정 > 관리**를 열 수 있는 권한

## 사용자와 권한

1. **설정 > 관리 > 사용자** (`/settings/admin/users`)를 엽니다.
2. 사용자를 만들거나 역할을 줍니다. 위험한 동작은 서버 권한 검사로 막힙니다. UI에서 버튼만 숨기는 것으로는 부족합니다.
3. 슈퍼유저가 아닌 관리자는 자기 권한이 닿는 화면만 봅니다. "관리자"가 곧 슈퍼유저는 아닙니다.
4. 계정 활동: **설정 > 관리 > 계정 활동**.
5. 매직 링크: **설정 > 관리 > 매직 링크**.

공개 가입은 설정에 따릅니다. 가입이 꺼져 있으면 **로그인**이나 발급한 매직 링크를 씁니다.

## SSO (OIDC)

**설정 > 관리 > OIDC** (`/settings/admin/oidc`)에서 Authentik, Keycloak, Authelia를 붙입니다. 콜백 URL은 `https://books.soverin.cloud`여야 합니다.

## 이메일

**설정 > 이메일** (`/settings/email`): 비밀번호 재설정, Send-to-Kindle, 알림용 SMTP. 제공자 비밀값은 git이 아니라 앱 설정 UI에 둡니다.

## 모양과 계정

- **설정 > 모양**: 테마, 표지, 아이콘, 레이아웃, 동작, 언어
- **설정 > 계정**: 프로필, 개인정보, 알림, 제한

## 시스템 (관리)

- 파일 이름: `/settings/library/file-naming`
- 유지보수: `/settings/library/maintenance`
- 감사 로그: `/settings/admin/audit-log`
- 서버 글꼴: `/settings/admin/server-fonts`
- Book Dock: `/settings/admin/book-dock`

## 확인

- 두 번째 사용자는 자기 읽기 데이터만 봅니다.
- 권한 없는 관리자는 URL을 알아도 API가 forbidden을 줍니다.

## 문제 해결

- **Invalid setup token**: 최초 관리자 마법사에만 필요합니다. 이후 사용자는 이 토큰이 필요 없습니다.
- 비밀번호를 잊음: SMTP가 되면 **비밀번호 찾기**. 아니면 사용자 화면의 재설정(있으면)을 쓰고, DB는 최후 수단입니다 ([운영](05-operations.md)).

[문제 해결](07-troubleshooting.md)을 보세요.
