#!/bin/sh
set -eu

if [ -n "${POSTGRES_CONNECTION_STRING:-}" ] && [ -z "${DATABASE_URL:-}" ]; then
  jdbc_url=$(printf '%s' "$POSTGRES_CONNECTION_STRING" | sed -E 's#^postgresql://([^:]+):([^@]+)@([^/]+)/(.+)$#jdbc:postgresql://\3/\4?user=\1&password=\2#')
  export DATABASE_URL="$jdbc_url"
fi

exec /docker-entrypoint.sh "$@"