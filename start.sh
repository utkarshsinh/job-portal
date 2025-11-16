#!/bin/bash

# Run migrations
php artisan migrate --force

# Seed database automatically if tables are empty
php check-and-seed.php

# Ensure production uses built assets (not Vite dev server)
rm -f public/hot

# Start the server
php artisan serve --host=0.0.0.0 --port=$PORT
