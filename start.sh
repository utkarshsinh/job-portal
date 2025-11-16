#!/bin/bash

echo "Starting container..."
echo ""

php artisan migrate --force || true

php check-and-seed.php || true

# Remove Vite dev server flag
rm -f public/hot

# Confirm manifest exists at the correct Laravel Vite location
if [ -f "public/build/manifest.json" ]; then
    echo "✓ Manifest found at public/build/manifest.json"
else
    echo "✗ Manifest missing! Build did not output manifest.json at public/build/manifest.json"
    echo "Checking public/build/ directory:"
    ls -la public/build/ || echo "public/build/ does not exist"
    exit 1
fi

echo "Starting Laravel..."
php artisan serve --host=0.0.0.0 --port=$PORT
