#!/bin/bash

echo "Starting Container"
echo ""

echo "Running migrations..."
php artisan migrate --force

php check-and-seed.php

# Prevent Vite dev server loading
rm -f public/hot

# FIX: Make sure manifest is in correct location
echo "Checking Vite manifest..."
if [ -f "public/build/manifest.json" ]; then
    echo "✓ Manifest already in correct location"
elif [ -f "public/build/.vite/manifest.json" ]; then
    echo "✓ Found Vite manifest under .vite"
    cp public/build/.vite/manifest.json public/build/manifest.json
    echo "✓ Copied manifest to public/build/manifest.json"
else
    echo "✗ Manifest NOT FOUND"
fi

echo "Starting Laravel..."
php artisan serve --host=0.0.0.0 --port=$PORT
