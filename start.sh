#!/bin/bash

echo "Starting container..."
echo ""

php artisan migrate --force || true

php check-and-seed.php || true

# Remove Vite dev server flag
rm -f public/hot

# Confirm manifest exists
if [ -f "public/build/manifest.json" ]; then
    echo "✓ Manifest found"
else
    echo "✗ Manifest missing! Build did not output manifest.json"
    ls -la public/build/
    exit 1
fi

echo "Starting Laravel..."
php artisan serve --host=0.0.0.0 --port=$PORT
