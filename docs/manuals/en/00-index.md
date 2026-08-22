# BookOrbit manuals (English)

This set covers the live instance at **https://books.soverin.cloud**.

The web UI also has a Korean catalog. Switch it in **Settings > Appearance > Language**. These manuals stay in English in this folder; the Korean twins live in [../ko/](../ko/00-index.md).

## Who should read what

| You want to...                                              | Start here                                        |
| ----------------------------------------------------------- | ------------------------------------------------- |
| Open the site, finish first-time setup, add the first books | [Getting started](01-getting-started.md)          |
| Create libraries, scan folders, import, edit metadata       | [Libraries and books](02-libraries-and-books.md)  |
| Use the web reader, Kobo, KOReader, OPDS                    | [Reading and device sync](03-reading-and-sync.md) |
| Add users, permissions, SSO, email                          | [Users and administration](04-users-and-admin.md) |
| Update Docker, backups, logs, DNS                           | [Operations](05-operations.md)                    |
| Paths, URLs, env keys, compose layout                       | [Reference](06-reference.md)                      |
| Fix login, token, scan, or HTTPS errors                     | [Troubleshooting](07-troubleshooting.md)          |

## What this instance is

BookOrbit is a self-hosted library for ebooks, PDFs, comics, and audiobooks. This copy runs as two Docker containers (`bookorbit-app`, `bookorbit-db`) on Hostinger VPS `srv1655088`, behind Traefik, with Cloudflare proxying `books.soverin.cloud`.

## Related

- Korean manuals: [../ko/00-index.md](../ko/00-index.md)
- Upstream product docs: [bookorbit.app](https://bookorbit.app/what-is-bookorbit)
