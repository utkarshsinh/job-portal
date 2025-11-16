# Fix Railway Variables - Remove Quotes

## Issue: Variables have quotes which can cause problems

Railway environment variables should **NOT have quotes** around the values.

## Correct Format (No Quotes):

Go to Railway → Web Service → Variables → Raw Editor

Replace everything with this (NO QUOTES):

```env
APP_NAME=Job Portal
APP_ENV=production
APP_DEBUG=false
APP_URL=https://web-production-cab50.up.railway.app
APP_KEY=base64:DzYP89fF1RKsEpZS+6WMKU9YHMP7CdrC8/NEqoHdZxA=
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

## Important Changes:

1. **Remove ALL quotes** from values
2. **Set APP_KEY** to: `base64:DzYP89fF1RKsEpZS+6WMKU9YHMP7CdrC8/NEqoHdZxA=`
3. **APP_NAME** should be: `Job Portal` (no quotes)

## Steps:

1. Go to Railway Dashboard
2. Web Service → Variables
3. Click "Raw Editor"
4. Delete everything
5. Paste the corrected version above (no quotes)
6. Click "Save"
7. Wait for redeploy (2-3 minutes)

This should fix your 500 error!

