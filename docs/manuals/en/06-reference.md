# Reference

Facts for this Hostinger install. Product-wide API docs stay at [bookorbit.app](https://bookorbit.app/what-is-bookorbit).

## URLs

| Purpose           | URL                                       |
| ----------------- | ----------------------------------------- |
| Public app        | https://books.soverin.cloud               |
| Health            | https://books.soverin.cloud/api/v1/health |
| Fallback host     | https://bookorbit.srv1655088.hstgr.cloud  |
| First-time wizard | https://books.soverin.cloud/setup         |
| Login             | https://books.soverin.cloud/login         |

## Host

| Item                | Value                    |
| ------------------- | ------------------------ |
| VPS hostname        | `srv1655088`             |
| Public IPv4         | `72.61.116.250`          |
| SSH (from this Mac) | `ssh hostinger-vps`      |
| Identity file       | `~/.ssh/hostinger_codex` |

## Docker

| Item                | Value                                                      |
| ------------------- | ---------------------------------------------------------- |
| Project dir         | `/docker/bookorbit`                                        |
| Compose file        | `/docker/bookorbit/docker-compose.yml`                     |
| App container       | `bookorbit-app`                                            |
| DB container        | `bookorbit-db`                                             |
| App image env       | `APP_IMAGE` (default `ghcr.io/bookorbit/bookorbit:latest`) |
| DB image            | `pgvector/pgvector:pg18`                                   |
| Docker network      | `bookorbit_default`                                        |
| Published host port | none (Traefik only)                                        |
| Container listen    | `3000`                                                     |

Traefik routers: `Host(books.soverin.cloud)` and `Host(bookorbit.srv1655088.hstgr.cloud)`, entrypoint `websecure`, certresolver `letsencrypt`.

## Bind mounts

| Host                              | Container                  |
| --------------------------------- | -------------------------- |
| `/docker/bookorbit/books`         | `/books`                   |
| `/docker/bookorbit/data/app`      | `/data`                    |
| `/docker/bookorbit/data/postgres` | `/var/lib/postgresql/data` |

## Environment (names only)

Required on this host (values live in `/docker/bookorbit/.env`, not here):

- `APP_IMAGE`, `APP_URL`, `CLIENT_URL`
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- `JWT_SECRET`, `SETUP_BOOTSTRAP_TOKEN`
- `BOOKS_HOST_PATH`, `PUID`, `PGID`, `LIBRARY_BROWSE_ROOT`

`APP_URL` and `CLIENT_URL` are `https://books.soverin.cloud`.

`SETUP_BOOTSTRAP_TOKEN` is required in production for `/auth/setup` (`x-setup-token` header). After the first admin exists, daily login does not use it.

## Main UI routes

| Area             | Path                    |
| ---------------- | ----------------------- |
| Home             | `/`                     |
| Libraries        | `/libraries`            |
| Book             | `/book/:bookId`         |
| Reader           | `/read/:bookId/:fileId` |
| Annotations      | `/annotations`          |
| Statistics       | `/statistics`           |
| Achievements     | `/achievements`         |
| Collections      | `/collections`          |
| Smart scopes     | `/smart-scopes`         |
| Authors / series | `/authors`, `/series`   |
| Tools            | `/tools`                |
| Kobo             | `/settings/kobo`        |
| KOReader         | `/settings/koreader`    |
| OPDS             | `/settings/opds`        |
| Users            | `/settings/admin/users` |

## Cloudflare DNS

| Type | Name    | Content         | Proxy   |
| ---- | ------- | --------------- | ------- |
| A    | `books` | `72.61.116.250` | Proxied |

## Related

- [Operations](05-operations.md)
- [Troubleshooting](07-troubleshooting.md)
- Upstream install: [bookorbit.app/installation](https://bookorbit.app/installation)
