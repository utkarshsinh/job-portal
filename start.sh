#!/bin/bash

echo "============================================"
echo "Starting Laravel Application (Railway)"
echo "============================================"
echo ""

# ----------------------------------------------------
# 1. Run Migrations
# ----------------------------------------------------
echo "Running migrations..."
php artisan migrate --force

# ----------------------------------------------------
# 2. Seed database if needed
# ----------------------------------------------------
echo "Checking and seeding database..."
php check-and-seed.php

# ----------------------------------------------------
# 3. Remove hot file (forces production mode)
# ----------------------------------------------------
echo "Ensuring no Vite dev server (removing public/hot)..."
rm -f public/hot

# ----------------------------------------------------
# 4. Ensure Vite manifest exists in correct location
# ----------------------------------------------------
echo ""
echo "Checking Vite manifest file..."

# Case 1: Vite 5 puts it here:
if [ -f "public/build/.vite/manifest.json" ]; then
    echo "✓ Found manifest in .vite folder"
    cp public/build/.vite/manifest.json public/build/manifest.json
    echo "✓ Copied manifest to public/build/manifest.json"
fi

# Case 2: Vite already created it correctly:
if [ -f "public/build/manifest.json" ]; then
    echo "✓ Manifest ready at public/build/manifest.json"
else
    echo "⚠ ERROR: No manifest.json found after build!"
    echo "   CSS/JS will not load."
fi

# ----------------------------------------------------
# 5. Display what files exist
# ----------------------------------------------------
echo ""
echo "Listing build directory:"
ls -R public/build/

# ----------------------------------------------------
# 6. Start Laravel server
# ----------------------------------------------------
echo ""
echo "Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
