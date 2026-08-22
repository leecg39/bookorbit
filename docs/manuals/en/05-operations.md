# How to operate this BookOrbit host

Update containers, read logs, back up data, and check DNS or Traefik. All commands assume SSH as configured on the Mac (`ssh hostinger-vps` -> `root@72.61.116.250`).

## Prerequisites

- SSH key `~/.ssh/hostinger_codex` and host alias `hostinger-vps`
- Do not stop unrelated stacks (smb, botanic, supabase, Traefik) unless you intend to

## Layout on the VPS

| Item            | Path or name                                               |
| --------------- | ---------------------------------------------------------- |
| Compose project | `/docker/bookorbit`                                        |
| Env file        | `/docker/bookorbit/.env` (mode 600)                        |
| Book files      | `/docker/bookorbit/books`                                  |
| App data        | `/docker/bookorbit/data/app`                               |
| Postgres data   | `/docker/bookorbit/data/postgres`                          |
| Containers      | `bookorbit-app`, `bookorbit-db`                            |
| Proxy           | existing `traefik-traefik-1` (host network, Let's Encrypt) |

## Status

```bash
ssh hostinger-vps 'docker ps --filter name=bookorbit; curl -fsS https://books.soverin.cloud/api/v1/health'
```

Healthy JSON includes `"status":"ok"` and database `"up"`.

## Logs

```bash
ssh hostinger-vps 'docker logs --tail 200 bookorbit-app'
ssh hostinger-vps 'docker logs --tail 100 bookorbit-db'
ssh hostinger-vps 'docker logs --since 10m traefik-traefik-1'
```

## GitHub

The VPS directory `/docker/bookorbit` tracks the private repo [leecg39/bookorbit](https://github.com/leecg39/bookorbit). `.env`, `books/`, and `data/` stay on the server and are not in git.

Push to `main` deploys through GitHub Actions (SSH). Manual pull:

```bash
ssh hostinger-vps 'bash /docker/bookorbit/deploy/hostinger/deploy.sh'
```

Live URLs after deploy: https://books.soverin.cloud and https://bookorbit.srv1655088.hstgr.cloud

## Update the app image

This host uses `APP_IMAGE=ghcr.io/bookorbit/bookorbit:latest`.

```bash
ssh hostinger-vps 'cd /docker/bookorbit && docker compose pull && docker compose up -d'
```

Watch health:

```bash
ssh hostinger-vps 'docker ps --filter name=bookorbit-app'
```

Pin a version in `.env` if you do not want `latest` (see [Reference](06-reference.md)).

## Restart

```bash
ssh hostinger-vps 'cd /docker/bookorbit && docker compose restart'
```

## Backup

Stop is optional but safer for a consistent Postgres directory copy.

```bash
ssh hostinger-vps 'cd /docker/bookorbit && docker compose stop'
# copy /docker/bookorbit/data and /docker/bookorbit/books off the box
ssh hostinger-vps 'cd /docker/bookorbit && docker compose start'
```

Keep `.env` in a secret store. Never put it in git.

Disk on this VPS is shared with other stacks. Check before large copies:

```bash
ssh hostinger-vps 'df -h /'
```

## DNS and TLS

Cloudflare zone `soverin.cloud`:

- Type A, name `books`, content `72.61.116.250`, **Proxied** (same as `smb.soverin.cloud`)

Traefik labels on `bookorbit-app` also serve `bookorbit.srv1655088.hstgr.cloud`. Prefer `books.soverin.cloud` for users and devices.

## What not to do

- Do not publish host port 3000. Open WebUI already binds `127.0.0.1:3000`. Traefik reaches the container on the Docker network.
- Do not `docker compose down -v` unless you intend to wipe Postgres.
- Do not prune unused images globally without checking other projects.

## Verification

- `https://books.soverin.cloud/api/v1/health` returns 200
- `docker inspect bookorbit-app --format '{{.State.Health.Status}}'` is `healthy`

## Troubleshooting

See [Troubleshooting](07-troubleshooting.md) if health fails after an update.
