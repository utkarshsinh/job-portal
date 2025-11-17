#!/bin/bash

echo "Starting container..."

php artisan migrate --force || true
php check-and-seed.php || true

# Remove Vite dev hot file (just in case)
rm -f public/hot

echo "Checking Vite build output..."

if [ -f "public/build/manifest.json" ]; then
    echo "✓ Manifest OK (public/build/manifest.json)"
else
    echo "✗ Manifest missing! Build probably failed or not included."
    ls -la public/build || echo "public/build missing"
fi

echo "Clearing Laravel caches..."
php artisan optimize:clear

echo "Starting Laravel..."
php artisan serve --host=0.0.0.0 --port=$PORT
