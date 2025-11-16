#!/bin/bash
# Railway Deployment Commands
# Run these commands after setting environment variables in Railway

echo "🚀 Railway Deployment Commands"
echo "================================"
echo ""

echo "1. Generate APP_KEY:"
echo "   railway run php artisan key:generate"
echo ""

echo "2. Run Migrations:"
echo "   railway run php artisan migrate --force"
echo ""

echo "3. Seed Database:"
echo "   railway run php artisan db:seed"
echo ""

echo "4. Clear Cache:"
echo "   railway run php artisan optimize:clear"
echo ""

echo "5. Rebuild Cache:"
echo "   railway run php artisan optimize"
echo ""

echo "================================"
echo "To use these commands:"
echo "1. Install Railway CLI: npm i -g @railway/cli"
echo "2. Login: railway login"
echo "3. Link project: railway link"
echo "4. Run commands above"
echo ""

