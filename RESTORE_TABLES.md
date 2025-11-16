# Restore Database Tables

## What Happened?

The tables might have been dropped due to:
1. Database reset in Railway
2. Database connection issue
3. Migration rollback (unlikely with `--force`)

## Good News: Tables Will Be Recreated Automatically

Your `start.sh` script runs `php artisan migrate --force` on every deployment, which will recreate all tables.

## Solution: Trigger a Redeploy

### Option 1: Wait for Next Deploy (Automatic)

If Railway is set to auto-deploy, the next deployment will:
1. ✅ Run migrations → Create all tables
2. ✅ Check if database is empty → Seed data
3. ✅ Start server

### Option 2: Manual Redeploy (Immediate)

1. Go to **Railway Dashboard** → **Web Service**
2. Go to **Deployments** tab
3. Click **"Redeploy"** on the latest deployment
4. Wait 2-3 minutes

### Option 3: Check Migration Status

If you want to verify what's happening, check Railway logs:
1. Go to **Railway Dashboard** → **Web Service** → **Logs**
2. Look for:
   - `"Running migrations..."`
   - `"Migrating: create_users_table"`
   - `"Migrated: create_users_table"`
   - Any errors

## What Tables Should Be Created

After migrations run, you should have:
- ✅ `users`
- ✅ `password_reset_tokens`
- ✅ `sessions`
- ✅ `cache`
- ✅ `cache_locks`
- ✅ `jobs` (queue jobs)
- ✅ `job_batches`
- ✅ `failed_jobs`
- ✅ `offered_jobs` (your job postings)
- ✅ `employers`
- ✅ `job_applications`

## After Tables Are Created

The `check-and-seed.php` script will automatically:
- Check if database is empty
- If empty → Seed all data (301 users, 20 employers, 100 jobs, etc.)
- If not empty → Skip seeding

## Quick Fix

**Just redeploy** - Railway will automatically:
1. Run migrations (recreate tables)
2. Seed data (if tables are empty)
3. Start the server

No manual steps needed!

