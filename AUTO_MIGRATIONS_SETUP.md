# Automatic Migrations on Railway

## What I Just Did

I updated `railway.json` to automatically run migrations before starting the server.

**Before:**
```json
"startCommand": "php artisan serve --host=0.0.0.0 --port=$PORT"
```

**After:**
```json
"startCommand": "php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT"
```

## What This Means

Now, every time Railway deploys your app:
1. ✅ It will automatically run migrations
2. ✅ Then start the server
3. ✅ Your database tables will be created automatically

## Next Steps

1. **Commit and push this change:**
   ```bash
   git add railway.json
   git commit -m "Add automatic migrations on Railway deployment"
   git push origin master
   ```

2. **Railway will automatically:**
   - Detect the push
   - Redeploy
   - Run migrations automatically
   - Start the server

3. **After deployment, seed the database:**
   - You'll still need to run seeders once
   - But migrations will run automatically!

## To Seed Database (One Time)

After the next deployment, you can seed via Railway dashboard if available, or we can set up automatic seeding too.

## Benefits

- ✅ No need to manually run migrations
- ✅ Migrations run automatically on every deploy
- ✅ Database stays in sync with your code
- ✅ No more "nothing to migrate" issues

