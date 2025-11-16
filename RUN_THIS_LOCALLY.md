# Run These Commands in Your Terminal

Railway CLI is installed! Now run these commands in your terminal:

## Step 1: Login to Railway

```bash
cd /Users/utkarshsinh/InterviewPreparation/php_laravel/laravel-course-2023/job-board
railway login
```

This will open your browser - click "Authorize" to login.

## Step 2: Link to Your Project

```bash
railway link
```

Select your project (`graceful-gentleness` or similar) when prompted.

## Step 3: Run Migrations on Railway

```bash
railway run php artisan migrate --force
```

This will create all tables (including sessions) on Railway's MySQL database.

## Step 4: Seed Database (Optional)

```bash
railway run php artisan db:seed
```

## Step 5: Test Your App

Visit: https://web-production-cab50.up.railway.app

It should work now! 🎉

---

## If You Get Errors:

- Make sure you're logged in: `railway whoami`
- Make sure project is linked: `railway status`
- Check Railway dashboard to verify connection

