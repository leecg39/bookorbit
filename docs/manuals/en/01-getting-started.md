# Getting started

You will open the live site, finish first-time admin setup if it is still pending, switch language if you want, and add a first library of books.

## What you need

- Browser (Chrome, Safari, Ego, or similar)
- The URL **https://books.soverin.cloud**
- If setup is not done yet: the production setup token from the server `.env` (not stored in this manual)

## Step 1: Open the site

Go to:

https://books.soverin.cloud

Fallback hostname (same app, Hostinger DNS):

https://bookorbit.srv1655088.hstgr.cloud

You should see either **Initial setup**, **Login**, or the dashboard.

## Step 2: Create the first administrator (one time)

If you see **Initial setup**:

1. Username, full name, email, password (min. 8 characters with uppercase, lowercase, and a digit).
2. Paste **Setup token** from `/docker/bookorbit/.env` on the VPS (`SETUP_BOOTSTRAP_TOKEN=`). Empty or wrong token returns **Invalid setup token**.
3. Click **Create administrator account**.
4. You land in the app as that admin user.

If you already created the account, use **Login** instead. Do not run setup again.

Read the token on the VPS (do not commit it):

```bash
ssh hostinger-vps 'grep ^SETUP_BOOTSTRAP_TOKEN= /docker/bookorbit/.env'
```

## Step 3: Switch the UI language (optional)

1. Open **Settings > Appearance > Language**.
2. Choose **Korean** (`ko`) or **English** (`en`).
3. The menus follow that catalog. These English manuals stay useful either way.

## Step 4: Point BookOrbit at your book files

Host folder on the VPS is mounted at `/books` in the container:

- Host: `/docker/bookorbit/books`
- Container: `/books`

Copy files onto the VPS (example from your Mac):

```bash
scp -r ./my-library hostinger-vps:/docker/bookorbit/books/
```

Or upload later in the web UI (drag and drop) if you prefer not to use SCP.

Then in the app:

1. Open **Libraries**.
2. Create a library and pick a folder under `/books`.
3. Run a scan so titles appear on the home shelves.

Details: [Libraries and books](02-libraries-and-books.md).

## What you built

A working admin session on https://books.soverin.cloud, with files landing in `/docker/bookorbit/books` and at least one library ready to scan.

Next: [Libraries and books](02-libraries-and-books.md) or [Reading and device sync](03-reading-and-sync.md).
