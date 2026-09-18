#!/usr/bin/env sh

set -eu

base_url="${1:-http://127.0.0.1:${APP_PORT:-8080}}"
response="$(curl --fail --silent --show-error "$base_url/healthz.php")"

printf '%s\n' "$response" | grep -q '"status":"ok"'
printf '%s\n' "Smoke check passed: $base_url/healthz.php"
