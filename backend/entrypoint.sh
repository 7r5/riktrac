#!/bin/sh
set -eu

if [ -n "${POSTGRES_CONNECTION_STRING:-}" ] && [ -z "${DATABASE_URL:-}" ]; then
  connection_without_scheme=${POSTGRES_CONNECTION_STRING#postgresql://}
  hostport=${connection_without_scheme#*@}
  hostport=${hostport%%/*}
  export DATABASE_URL="jdbc:postgresql://${hostport}/${DATABASE_NAME}"
fi

cd /opt/traccar
exec /opt/traccar/jre/bin/java -XX:+ExitOnOutOfMemoryError "$@"