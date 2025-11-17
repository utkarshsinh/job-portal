#!/bin/bash

echo "Starting container..."
echo ""

php artisan migrate --force || true
php check-and-seed.php || true

rm -f public/hot

# Only look for correct manifest
if [ -f "public/build/manifest.json" ]; then
    echo "✓ Manifest found at public/build/manifest.json"
else
    echo "✗ Manifest missing!"
    ls -la public/build/
    exit 1
fi

echo "Clearing Laravel caches..."
php artisan view:clear
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan optimize:clear
echo "✓ All caches cleared"

echo "Starting Laravel..."
php artisan serve --host=0.0.0.0 --port=$PORT
