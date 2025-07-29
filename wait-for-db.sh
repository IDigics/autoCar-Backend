#!/bin/sh
# wait-for-db.sh

set -e

host="$1"
shift
cmd="$@"

# Use pg_isready which is more reliable than psql for connection testing
until pg_isready -h "$host" -U admin -d autocar -t 5; do
  >&2 echo "Postgres at $host is unavailable - sleeping"
  sleep 2
done

>&2 echo "Postgres is up - executing command"
exec $cmd