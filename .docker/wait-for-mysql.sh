#!/bin/bash
set -e

host="$DB_HOST"
port="$DB_PORT"

echo "⏳ Menunggu MySQL di $host:$port..."

until nc -z "$host" "$port"; do
  sleep 1
done

echo "✅ MySQL sudah siap!"

exec "$@"
