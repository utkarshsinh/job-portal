# 🔧 Railway 500 Error Troubleshooting

## Step 1: Check Deployment Logs

1. Go to Railway Dashboard
2. Click on your **Web Service**
3. Click **"Deployments"** tab
4. Click on the **latest deployment**
5. Click **"View Logs"**
6. **Scroll to the bottom** - look for error messages

**Common errors you might see:**
- "No application encryption key has been specified" → Missing APP_KEY
- "SQLSTATE[HY000]" → Database connection error
- "Class not found" → Missing dependencies
- "Permission denied" → File permission issues

---

## Step 2: Check Environment Variables

In Railway Dashboard → Web Service → Variables, verify these are set:

### Required Variables:
```env
APP_KEY=base64:... (must be set!)
APP_ENV=production
APP_DEBUG=false
APP_URL=https://web-production-cab50.up.railway.app
DB_CONNECTION=mysql
DB_HOST=mysql.railway.internal
DB_PORT=3306
DB_DATABASE=railway
DB_USERNAME=root
DB_PASSWORD=nnNsEbvqMoOouNUqJDnbbToULeLbQBJi
```

### Quick Check:
- [ ] APP_KEY is set (not empty)
- [ ] All DB_ variables are set
- [ ] APP_URL matches your Railway URL

---

## Step 3: Common Fixes

### Fix 1: Generate APP_KEY

If APP_KEY is missing or empty:

**Option A: Using Railway Dashboard**
1. Go to Variables
2. Add/Update: `APP_KEY` (leave empty, Railway generates it)
3. Or manually generate:

**Option B: Generate Locally**
```bash
cd /path/to/your/project
php artisan key:generate --show
```
Copy the output and add it as `APP_KEY` in Railway Variables.

**Option C: Using Railway CLI**
```bash
railway run php artisan key:generate
```

### Fix 2: Check Database Connection

Verify MySQL service is running:
1. In Railway, check MySQL service status (should be green/running)
2. Verify all DB_ variables match your MySQL service variables

### Fix 3: Run Migrations

If database tables don't exist:
```bash
railway run php artisan migrate --force
```

### Fix 4: Clear Cache

Sometimes cached config causes issues:
```bash
railway run php artisan config:clear
railway run php artisan cache:clear
railway run php artisan view:clear
```

### Fix 5: Enable Debug Mode Temporarily

To see actual error (ONLY for debugging, disable after):

In Railway Variables:
```env
APP_DEBUG=true
```

This will show the actual error message. **Remember to set it back to `false` after fixing!**

---

## Step 4: Check Specific Errors

### Error: "No application encryption key"
**Solution:** Generate APP_KEY (see Fix 1)

### Error: "SQLSTATE[HY000] [2002] Connection refused"
**Solution:** 
- Check DB_HOST is `mysql.railway.internal` (not `127.0.0.1`)
- Verify MySQL service is running
- Check DB credentials match MySQL service

### Error: "Class 'X' not found"
**Solution:**
- Run: `railway run composer install --no-dev`
- Redeploy

### Error: "Permission denied" on storage
**Solution:**
Add to Railway Variables:
```env
STORAGE_LINK=true
```

Or run:
```bash
railway run php artisan storage:link
```

---

## Step 5: Complete Reset (If Nothing Works)

1. **Clear all caches:**
   ```bash
   railway run php artisan optimize:clear
   ```

2. **Regenerate config:**
   ```bash
   railway run php artisan config:cache
   ```

3. **Run migrations fresh (WARNING: deletes data):**
   ```bash
   railway run php artisan migrate:fresh --force
   railway run php artisan db:seed
   ```

4. **Redeploy:**
   - In Railway, click "Redeploy" on your service

---

## Quick Diagnostic Commands

Run these in Railway Shell/Command to diagnose:

```bash
# Check PHP version
php -v

# Check if APP_KEY is set
php artisan tinker --execute="echo config('app.key');"

# Test database connection
php artisan tinker --execute="DB::connection()->getPdo(); echo 'DB Connected!';"

# Check environment
php artisan tinker --execute="echo env('APP_ENV'); echo env('DB_CONNECTION');"
```

---

## What to Share With Me

If still having issues, share:

1. **Error from logs** (copy the full error message)
2. **Which variables are set** (screenshot or list)
3. **MySQL service status** (is it running?)
4. **Deployment status** (did it deploy successfully?)

---

## Most Common Issue: Missing APP_KEY

**90% of 500 errors are due to missing APP_KEY!**

Make sure `APP_KEY` is set in Railway Variables. If empty, generate it using one of the methods above.

