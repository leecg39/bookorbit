# How to manage users and administration

Add people, set permissions, and keep admin-only tools behind server checks. This app is multi-user: each user's library data is scoped by `userId`.

## Prerequisites

- First administrator already created ([Getting started](01-getting-started.md))
- Permission to open **Settings > Admin**

## Users and permissions

1. Open **Settings > Admin > Users** (`/settings/admin/users`).
2. Create users or assign roles. Destructive actions are gated on the server with permission checks; hiding a button in the UI is not enough.
3. Non-superuser admins only see sections their permissions allow. Do not assume "admin" equals superuser.
4. Account activity: **Settings > Admin > Account activity**.
5. Magic links: **Settings > Admin > Magic links**.

Registration of new public accounts follows whatever you set for open registration. If registration is off, people use **Login** or a magic link you issue.

## SSO (OIDC)

**Settings > Admin > OIDC** (`/settings/admin/oidc`) for Authentik, Keycloak, or Authelia. Callback URL must use `https://books.soverin.cloud`.

## Email

**Settings > Email** (`/settings/email`): SMTP for password reset, Send-to-Kindle, and notifications. Store provider secrets in the app settings UI, not in git.

## Appearance and account

- **Settings > Appearance**: theme, covers, icons, layout, behavior, language
- **Settings > Account**: profile, privacy, notifications, restrictions

## System (admin)

- File naming: `/settings/library/file-naming`
- Maintenance: `/settings/library/maintenance`
- Audit log: `/settings/admin/audit-log`
- Server fonts: `/settings/admin/server-fonts`
- Book Dock: `/settings/admin/book-dock`

## Verification

- A second user can log in and only sees their own reading data.
- An admin without a permission cannot complete that action (API returns forbidden even if they guess the URL).

## Troubleshooting

- "Invalid setup token": only the first admin wizard. Later users never need that token.
- Forgotten password: **Forgot password** if SMTP works; otherwise an admin resets from the users page when that action exists, or use DB only as last resort (see [Operations](05-operations.md)).

See [Troubleshooting](07-troubleshooting.md).
