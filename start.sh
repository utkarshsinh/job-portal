#!/bin/bash

# Run migrations
php artisan migrate --force

# Seed database if SEED_DATABASE is set to true
# Handle both "true" and true (with/without quotes)
SEED_VALUE=$(echo "$SEED_DATABASE" | tr -d '"' | tr '[:upper:]' '[:lower:]')
if [ "$SEED_VALUE" = "true" ]; then
    echo "Seeding database..."
    php artisan db:seed --force
else
    echo "Skipping database seeding (set SEED_DATABASE=true to enable)"
    echo "Current SEED_DATABASE value: '$SEED_DATABASE'"
fi

# Start the server
php artisan serve --host=0.0.0.0 --port=$PORT

