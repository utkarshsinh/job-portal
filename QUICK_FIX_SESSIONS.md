# Quick Fix: Change Sessions to File-Based

## Option A: Quick Fix (No Migration Needed) - 2 Minutes

Change `SESSION_DRIVER` from `database` to `file`:

1. Railway Dashboard → Web Service → Variables → Raw Editor
2. Find: `SESSION_DRIVER=database`
3. Change to: `SESSION_DRIVER=file`
4. Save
5. Wait for redeploy
6. **App will work immediately!**

## Updated Variables (Quick Fix Version):

```env
APP_NAME=Job Portal
APP_ENV=production
APP_DEBUG=true
APP_URL=https://web-production-cab50.up.railway.app
APP_KEY=base64:DzYP89fF1RKsEpZS+6WMKU9YHMP7CdrC8/NEqoHdZxA=
LOG_CHANNEL=stderr
DB_CONNECTION=mysql
DB_HOST=mysql.railway.internal
DB_PORT=3306
DB_DATABASE=railway
DB_USERNAME=root
DB_PASSWORD=nnNsEbvqMoOouNUqJDnbbToULeLbQBJi
SESSION_DRIVER=file
SESSION_LIFETIME=120
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
```

**This will fix the error immediately!**

---

## Option B: Proper Fix (Run Migrations) - Use Railway CLI

If you want to use database sessions (proper way):

### Step 1: Install Railway CLI

```bash
npm i -g @railway/cli
```

### Step 2: Login and Link

```bash
railway login
railway link
# Select your project
```

### Step 3: Run Migrations

```bash
railway run php artisan migrate --force
railway run php artisan db:seed
```

### Step 4: Create Sessions Table (if needed)

```bash
railway run php artisan session:table
railway run php artisan migrate
```

---

## Recommendation: Use Option A (Quick Fix)

For now, use `SESSION_DRIVER=file` to get your app working immediately. You can switch back to database sessions later after running migrations.

