# Troubleshooting

Common failures on **https://books.soverin.cloud** and this VPS.

## Invalid setup token

**Symptom:** Initial setup form shows red **Invalid setup token** (API `POST /api/v1/auth/setup` returns 403).

**Cause:** Production compares `x-setup-token` to `SETUP_BOOTSTRAP_TOKEN`. Empty field or a typo fails.

**Fix:**

```bash
ssh hostinger-vps 'grep ^SETUP_BOOTSTRAP_TOKEN= /docker/bookorbit/.env'
```

Paste the value into **Setup token**. Password still needs 8+ characters with upper, lower, and a digit.

After the first admin exists, you should use **Login**, not setup.

## Site will not load (DNS or TLS)

**Symptom:** NXDOMAIN, browser SSL error, or timeout.

**Checks:**

```bash
dig +short A books.soverin.cloud
curl -fsS -o /dev/null -w '%{http_code}\n' https://books.soverin.cloud/api/v1/health
ssh hostinger-vps 'docker logs --since 15m traefik-traefik-1 | grep -i books.soverin || true'
```

Cloudflare must have A `books` -> `72.61.116.250` Proxied. Fallback: https://bookorbit.srv1655088.hstgr.cloud

## Health down or app restarting

```bash
ssh hostinger-vps 'docker ps -a --filter name=bookorbit; docker logs --tail 80 bookorbit-app'
```

Postgres must be healthy before the app stays up. Disk full (`df -h /`) also kills writes.

## Empty library after copying files

- Files must sit under `/docker/bookorbit/books`
- Library folder in the UI must be under `/books`
- Run a scan after copy
- `PUID`/`PGID` in `.env` must match the owner of that folder

## Cannot reach Kobo or KOReader

- Device URL must be `https://books.soverin.cloud`, not port 3000
- Re-download the KOReader plugin after URL changes
- Cloudflare proxy must stay on for `books` (same as `smb`)

## 403 on admin actions

The API enforces permissions. A user without the permission cannot use that settings page even with a guessed URL. Use a superuser or grant the permission.

## Login loop or cookies

Use HTTPS on `books.soverin.cloud`. Mixing the hstgr hostname and the Cloudflare hostname in one session can confuse cookies. Pick one host and stay on it.

## Still stuck

Collect:

- Browser URL and status code
- `docker logs --tail 100 bookorbit-app` (no `.env` contents in chat)
- Time of the request (UTC or KST)

Then see [Operations](05-operations.md) and [Reference](06-reference.md).
