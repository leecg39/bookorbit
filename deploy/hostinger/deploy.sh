#!/usr/bin/env bash
set -euo pipefail

ROOT=/docker/bookorbit
cd "$ROOT"

git fetch origin
git checkout -B main origin/main

docker compose -f docker-compose.hostinger.yml pull
docker compose -f docker-compose.hostinger.yml up -d

docker compose -f docker-compose.hostinger.yml ps
curl -fsS https://books.soverin.cloud/api/v1/health
echo
curl -fsS https://bookorbit.srv1655088.hstgr.cloud/api/v1/health
echo
