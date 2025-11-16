# Fix: See Application Logs in Railway

## Issue: Can't See Application Logs

Railway requires logs to be sent to `stderr` to appear in the logs dashboard.

## Solution: Add LOG_CHANNEL

Add this to your Railway Variables:

```env
LOG_CHANNEL=stderr
```

## Complete Updated Variables List

Go to Railway → Web Service → Variables → Raw Editor

Paste this complete list (includes LOG_CHANNEL):

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
SESSION_DRIVER=database
SESSION_LIFETIME=120
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
```

## After Adding LOG_CHANNEL

1. **Save** the variables
2. **Wait for redeploy** (2-3 minutes)
3. **Visit your app** to trigger an error
4. **Check Logs tab** - you should now see application errors!

## Why This Works

- Railway captures output from `stderr`
- Laravel's default log channel writes to files
- Setting `LOG_CHANNEL=stderr` makes Laravel write to stderr
- Now Railway can capture and display the logs

## After You See the Error

1. **Copy the error from logs**
2. **Share it with me** so I can help fix it
3. **Once fixed, change**: `APP_DEBUG=false` (for security)

