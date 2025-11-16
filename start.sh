#!/bin/bash

echo "🚀 Starting Container"
echo ""

# --------------------------
# 1. Run migrations
# --------------------------
echo "Running migrations..."
php artisan migrate --force

# Seed database
php check-and-seed.php || true

# --------------------------
# 2. Ensure Vite manifest exists
# --------------------------
echo ""
echo "🔎 Checking manifest file..."

# Path Railway Vite puts it
VITE_PATH="public/build/.vite/manifest.json"
# Path Laravel expects it
FINAL_PATH="public/build/manifest.json"

# Remove Vite dev server file
rm -f public/hot

# If Vite wrote to .vite folder, copy to expected folder
if [ -f "$VITE_PATH" ]; then
    echo "✓ Found Vite manifest at .vite folder"
    echo "📄 Copying to public/build/manifest.json..."
    cp "$VITE_PATH" "$FINAL_PATH"
else
    echo "⚠ No manifest found in .vite. Listing public/build directory:"
    ls -R public/build/
fi

# Confirm the final manifest exists before starting Laravel
if [ ! -f "$FINAL_PATH" ]; then
    echo "❌ Manifest STILL missing. Laravel will fail."
    echo "Stopping container."
    exit 1
fi

echo "✓ Manifest ready"
echo ""

# --------------------------
# 3. Start Laravel
# --------------------------
echo "Starting Laravel..."
php artisan serve --host=0.0.0.0 --port=$PORT
