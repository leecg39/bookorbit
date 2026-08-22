# How to read and sync devices

Use the web reader, then connect a Kobo, KOReader, or an OPDS app so progress and highlights move with you.

## Prerequisites

- At least one book in a library
- For Kobo: a device that can use a custom sync URL
- For KOReader: a device with KOReader installed
- Public URL of this instance: **https://books.soverin.cloud** (use this, not the Hostinger hostname, for device URLs)

## Web reader

1. Open a book from the home shelves or a library.
2. Click through to the reader (`/read/:bookId/:fileId`).
3. Supported families include EPUB, KEPUB, MOBI, AZW3, PDF, CBZ/CBR/CB7, and common audiobook formats (M4B, MP3, and others).
4. Highlights and notes from the web reader show under **Annotations** (`/annotations`).
5. Reader defaults: **Settings > Reader** (ebook, PDF, comics, audio, fonts).

## Kobo sync

1. Open **Settings > Kobo** (`/settings/kobo`).
2. Follow the on-screen pairing steps for your firmware. The sync endpoint must use `https://books.soverin.cloud`.
3. After pairing, send books to the device from the library as the UI allows.
4. Reading progress, highlights, and deletions sync both ways with the web reader when Kobo sync is healthy.

If the device cannot reach the host, check Cloudflare proxy and Traefik (see [Operations](05-operations.md)). Do not point Kobo at `http://` or at an IP on port 3000; this install does not publish app port 3000 on the public internet.

## KOReader plugin

1. Open **Settings > KOReader** (`/settings/koreader`).
2. Create credentials if prompted.
3. Click **Download Plugin**. The zip is pre-filled with this server URL.
4. Unzip `bookorbit.koplugin.zip`.
5. Copy `bookorbit.koplugin` to `koreader/plugins/` on the device.
6. Restart KOReader, open a book, then **Tools > BookOrbit Sync**.

You get catalog browse, search, download, progress sync, and two-way annotations.

Upstream detail: [bookorbit.app/koreader-plugin](https://bookorbit.app/koreader-plugin).

## OPDS and Send-to-Kindle

- **OPDS**: **Settings > OPDS** (`/settings/opds`). Point a compatible client at the OPDS URL shown there (HTTPS on `books.soverin.cloud`).
- **Send-to-Kindle**: configure email under **Settings > Email**, then use the send action on a book when SMTP is set.

## Reading stats

- **Statistics** (`/statistics`): time, heatmaps, streaks
- **Achievements** (`/achievements`)
- Optional outbound sync: **Settings > Hardcover**, **Readwise**, **StoryGraph**

## Verification

- A book opens in the browser reader.
- After Kobo or KOReader setup, progress on the device appears in BookOrbit (or the other way around) after a sync.
- OPDS clients list the catalog over HTTPS.

## Troubleshooting

- Device cannot connect: DNS for `books.soverin.cloud` must resolve (Cloudflare). Traefik must serve Host `books.soverin.cloud`.
- Plugin zip has the wrong host: download it again after `APP_URL` is `https://books.soverin.cloud` (already set on this host).
- Highlights missing: check **Annotations** and that both sides finished a sync, not only a file copy.

See [Troubleshooting](07-troubleshooting.md).
