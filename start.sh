#!/bin/bash

# Run migrations
php artisan migrate --force

# Seed database if SEED_DATABASE is set to true
if [ "$SEED_DATABASE" = "true" ]; then
    echo "Seeding database..."
    php artisan db:seed
else
    echo "Skipping database seeding (set SEED_DATABASE=true to enable)"
fi

# Start the server
php artisan serve --host=0.0.0.0 --port=$PORT

