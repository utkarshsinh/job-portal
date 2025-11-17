#!/bin/bash

echo "Starting container..."

php artisan migrate --force || true

php check-and-seed.php || true

rm -f public/hot

php artisan optimize:clear

echo "✓ Caches cleared"

php artisan serve --host=0.0.0.0 --port=$PORT
