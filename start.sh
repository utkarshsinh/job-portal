#!/bin/bash

echo "Starting Container"
echo ""

# Run migrations
echo "Running migrations..."
php artisan migrate --force

# Seed database automatically if tables are empty
php check-and-seed.php

# Ensure production uses built assets (not Vite dev server)
rm -f public/hot

echo "Checking manifest file location..."
# Vite v5 may emit manifest under .vite; copy to expected root if needed
if [ -f "public/build/.vite/manifest.json" ]; then
  echo "✓ Found Vite manifest (.vite folder)"
  cp public/build/.vite/manifest.json public/build/manifest.json
  echo "✓ Copied manifest to expected location"
else
  if [ -f "public/build/manifest.json" ]; then
    echo "✓ Found Vite manifest at expected location"
  else
    echo "✗ manifest.json NOT found in public/build"
    ls -la public/build || true
  fi
fi

# Start the server
echo ""
php artisan serve --host=0.0.0.0 --port=$PORT
