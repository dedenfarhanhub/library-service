#!/bin/sh

# Exit on error
set -e

# Wait for MySQL to be ready
echo "🕒 Waiting for MySQL..."
/app/.docker/wait-for-mysql.sh

# Run migrations
echo "🛠 Running DB migrations..."
bundle exec rake db:migrate

# Start Puma
echo "🚀 Starting Puma..."
exec bundle exec puma -C puma.rb
