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

# Verify CSS/JS assets are built
if [ -f "public/build/.vite/manifest.json" ]; then
    echo "✓ CSS/JS assets found"
else
    echo "⚠ Warning: CSS/JS assets not found. Make sure 'npm run build' ran during deployment."
    echo "  Expected: public/build/.vite/manifest.json"
fi

# Start the server
echo ""
php artisan serve --host=0.0.0.0 --port=$PORT
