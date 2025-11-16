# Railway Deployment Guide - Step by Step

## 🚀 Quick Deploy to Railway (Easiest Method)

### Step 1: Sign Up for Railway

1. Go to [railway.app](https://railway.app)
2. Click "Start a New Project"
3. Sign up with GitHub (recommended - connects to your repo)

### Step 2: Create New Project

1. Click "New Project"
2. Select "Deploy from GitHub repo"
3. Choose your repository: `utkarshsinh/job-portal`
4. Railway will detect it's a Laravel app

### Step 3: Add Database

1. In your Railway project dashboard, click "+ New"
2. Select "Database" → "Add PostgreSQL" (or MySQL)
3. Railway will automatically create a database
4. **Note the connection details** - you'll need them in Step 5

### Step 4: Configure Environment Variables

In Railway dashboard, go to your web service → "Variables" tab, add these:

```env
APP_NAME="Job Portal"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-app-name.up.railway.app

# Database (Railway will auto-populate these from the database service)
# Just verify these are set:
DB_CONNECTION=pgsql
DB_HOST=${{Postgres.PGHOST}}
DB_PORT=${{Postgres.PGPORT}}
DB_DATABASE=${{Postgres.PGDATABASE}}
DB_USERNAME=${{Postgres.PGUSER}}
DB_PASSWORD=${{Postgres.PGPASSWORD}}

# Session
SESSION_DRIVER=database
SESSION_LIFETIME=120

# Cache
CACHE_DRIVER=file
QUEUE_CONNECTION=sync

# Mail (optional - for now)
MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
```

**Important:** Railway automatically creates database variables like `${{Postgres.PGHOST}}` - use those!

### Step 5: Generate App Key

1. In Railway, go to your web service
2. Click on "Deployments" → "View Logs"
3. Or use Railway CLI (optional):
   ```bash
   railway run php artisan key:generate
   ```

Actually, Railway will auto-generate it, but you can manually set it:
- In Variables, add: `APP_KEY` (leave empty, Railway will generate)

### Step 6: Deploy!

Railway will automatically:
1. Detect your Laravel app
2. Install Composer dependencies
3. Install npm dependencies
4. Build your assets
5. Run migrations (if configured)

### Step 7: Run Migrations

After first deployment:

1. Go to Railway dashboard
2. Click on your web service
3. Go to "Deployments" tab
4. Click on the latest deployment
5. Open "View Logs"
6. Or use Railway CLI:
   ```bash
   railway run php artisan migrate --force
   ```

### Step 8: Seed Database (Optional)

```bash
railway run php artisan db:seed
```

### Step 9: Get Your URL

1. Railway will give you a URL like: `https://your-app-name.up.railway.app`
2. Click on it to see your deployed app!

---

## 🛠️ Railway CLI (Optional - Easier Management)

Install Railway CLI for easier management:

```bash
# Install
npm i -g @railway/cli

# Login
railway login

# Link to your project
railway link

# Run commands
railway run php artisan migrate
railway run php artisan db:seed
```

---

## 📝 Important Notes

1. **Database**: Railway uses PostgreSQL by default (better than MySQL for this)
2. **File Storage**: Railway's file system is ephemeral - use S3 or similar for file uploads in production
3. **Queue Workers**: For production, you might need to set up a separate service for queue workers
4. **Custom Domain**: Railway allows custom domains (paid plan)

---

## 🔧 Troubleshooting

### If deployment fails:

1. Check logs in Railway dashboard
2. Common issues:
   - Missing environment variables
   - Database connection issues
   - Build errors

### If database connection fails:

1. Make sure database service is running
2. Check that database variables are correctly referenced
3. Use Railway's auto-generated database variables

---

## 💰 Pricing

- **Free Tier**: $5 credit/month (usually enough for small apps)
- **Hobby Plan**: $5/month + usage
- **Pro Plan**: $20/month + usage

Most small apps stay within free tier!

---

## ✅ Quick Checklist

- [ ] Signed up for Railway
- [ ] Connected GitHub repo
- [ ] Added PostgreSQL database
- [ ] Set environment variables
- [ ] Deployed successfully
- [ ] Ran migrations
- [ ] Tested the app URL

---

## 🎉 You're Done!

Your app should now be live at: `https://your-app-name.up.railway.app`

Need help? Check Railway docs: https://docs.railway.app

