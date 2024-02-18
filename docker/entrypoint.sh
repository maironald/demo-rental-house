#!/bin/bash -e
# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Database migration
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create db:migrate

# Precompile assets
bundle exec rails assets:precompile

# Create empty crontab file.
crontab -l | { cat; echo ""; } | crontab -

exec "${@}"
