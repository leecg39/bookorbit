# How to manage libraries and books

Create libraries, scan folders, import files, and refresh metadata without loading the whole collection into the browser at once. This instance is meant for large personal libraries.

## Prerequisites

- Admin or a role that may create libraries and scan
- Files under `/docker/bookorbit/books` on the VPS, or uploads through the UI
- Logged in at https://books.soverin.cloud

## Create a library

1. Open **Libraries**.
2. Create a library and give it a name.
3. Set the folder to a path under `/books` (the container view of `/docker/bookorbit/books`). Do not point at `/` on the container root unless you intend to.
4. Set scan rules and format priority if you keep several formats of the same title (EPUB vs KEPUB vs PDF).
5. Save, then run a scan.

The folder picker starts at `/books` because `LIBRARY_BROWSE_ROOT=/books` is set on this host.

## Add files

**Copy on the server** when you already have a tree on disk:

```bash
ssh hostinger-vps
# then copy into /docker/bookorbit/books/...
```

From your Mac:

```bash
scp -r /path/to/books hostinger-vps:/docker/bookorbit/books/
```

**Upload in the browser** with drag and drop when you add a few files.

**Book Dock** for hands-free ingest: **Settings > System / Book Dock** (`/settings/admin/book-dock`). Files dropped in the configured dock folder are imported without a manual scan each time.

## Scan and metadata

1. After files land, start a library scan from the library page.
2. Wait for progress. Tens of thousands of books are scanned in batches; do not expect an instant full-library list in one response.
3. Open a book, then refresh metadata if the title or cover is wrong.
4. Providers live under **Settings > Metadata > Providers** (Google Books, Open Library, Amazon, Goodreads, Kobo, Hardcover, Audible, Aladin, and others).
5. Field rules, custom fields, auto-fetch, authors, and genre blocklist are under **Settings > Metadata**.

Korean catalogs can use **Aladin** when you enable that provider.

## Organize

- **Collections**: curated lists (`/collections`)
- **Smart scopes**: rule-based saved filters (`/smart-scopes`)
- **Authors** and **Series**: `/authors`, `/series`
- **Tools**: entity manager, bulk rename, duplicate books (`/tools`)

Edit one book at `/book/:id/edit`. Manage files at `/book/:id/files`.

## Verification

- Home or the library page lists the new titles after the scan finishes.
- Opening a book shows cover and metadata.
- Files you copied appear under the library folder you selected.

## Troubleshooting

- Empty library after copy: confirm files are under `/docker/bookorbit/books` and the library folder matches that path inside `/books`.
- Permission errors on scan: host UID/GID should match `PUID`/`PGID` in `/docker/bookorbit/.env` (defaults `1000`/`1000`).
- Scan feels stuck: check **Operations** logs (`docker logs bookorbit-app`).

See [Troubleshooting](07-troubleshooting.md).
