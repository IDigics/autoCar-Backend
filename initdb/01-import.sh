#!/bin/bash
set -e

# Wait for PostgreSQL to be ready (with timeout)
timeout=60
while ! psql -U admin -d autocar -c "SELECT 1" >/dev/null 2>&1; do
  sleep 1
  ((timeout--))
  if [ $timeout -eq 0 ]; then
    echo "Database startup timed out"
    exit 1
  fi
done

# Import dump if exists
if [ -f "/docker-entrypoint-initdb.d/dump.sql.bak" ]; then
  echo "Importing database dump..."
  psql -v ON_ERROR_STOP=1 -U admin -d autocar -f /docker-entrypoint-initdb.d/dump.sql.bak
fi