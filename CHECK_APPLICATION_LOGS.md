# How to Check Application Logs for 500 Error

## The Error You're Seeing

The request log shows the app is running, but returning a 500 error. We need to see the **actual application error**.

## Step 1: Check Deployment/Application Logs

1. **Go to Railway Dashboard**
2. **Click on your Web Service**
3. **Click "Deployments" tab**
4. **Click on the latest deployment**
5. **Click "View Logs"** (or "Logs" tab)
6. **Scroll to the bottom** - look for PHP/Laravel errors

## What to Look For:

Common errors you might see:

### Error 1: "No application encryption key"
```
RuntimeException: No application encryption key has been specified.
```
**Fix**: APP_KEY is missing or empty - make sure it's set in variables

### Error 2: Database Connection Error
```
SQLSTATE[HY000] [2002] Connection refused
SQLSTATE[HY000] [1045] Access denied
```
**Fix**: Database credentials are wrong or MySQL service not running

### Error 3: Missing Class/File
```
Class 'X' not found
```
**Fix**: Dependencies not installed - redeploy

### Error 4: Migration Error
```
Table 'users' doesn't exist
```
**Fix**: Run migrations: `php artisan migrate --force`

## Step 2: Enable Debug Mode Temporarily

To see the actual error on the page:

1. **Go to Variables**
2. **Change**: `APP_DEBUG=true` (temporarily)
3. **Save** - wait for redeploy
4. **Visit your app** - you'll see the actual error message
5. **After fixing, change back to**: `APP_DEBUG=false`

## Step 3: Check Specific Issues

### Check if APP_KEY is set:
In Railway Shell/Command, run:
```bash
php artisan tinker --execute="echo config('app.key');"
```
If empty, APP_KEY is not set correctly.

### Check database connection:
```bash
php artisan tinker --execute="DB::connection()->getPdo(); echo 'Connected!';"
```
If error, database connection is failing.

## What I Need From You:

1. **Copy the error from "View Logs"** (the actual PHP/Laravel error, not the request log)
2. **Or enable APP_DEBUG=true** and share the error shown on the page
3. **Share which step you're on** (variables set? migrations run?)

The request log you shared shows the app is running, but we need the application error to fix it!

