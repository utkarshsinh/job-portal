# Railway Variables - Using Service References

## ✅ Correct Way: Use Railway Service References

Railway provides automatic variables when services are connected. Use these instead of hardcoded values.

## Updated Variables for Your Web Service:

Go to Railway → **Web Service** → Variables → Raw Editor

Paste this (using Railway's service references):

```env
APP_NAME=Job Portal
APP_ENV=production
APP_DEBUG=false
APP_URL=https://web-production-cab50.up.railway.app
APP_KEY=base64:DzYP89fF1RKsEpZS+6WMKU9YHMP7CdrC8/NEqoHdZxA=
DB_CONNECTION=mysql
DB_HOST=${{MySQL.MYSQLHOST}}
DB_PORT=${{MySQL.MYSQLPORT}}
DB_DATABASE=${{MySQL.MYSQL_DATABASE}}
DB_USERNAME=${{MySQL.MYSQLUSER}}
DB_PASSWORD=${{MySQL.MYSQLPASSWORD}}
SESSION_DRIVER=database
SESSION_LIFETIME=120
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
```

## Alternative: If Service References Don't Work

If `${{MySQL.MYSQLHOST}}` doesn't work, use the direct values from your MySQL service:

```env
APP_NAME=Job Portal
APP_ENV=production
APP_DEBUG=false
APP_URL=https://web-production-cab50.up.railway.app
APP_KEY=base64:DzYP89fF1RKsEpZS+6WMKU9YHMP7CdrC8/NEqoHdZxA=
DB_CONNECTION=mysql
DB_HOST=${{RAILWAY_PRIVATE_DOMAIN}}
DB_PORT=3306
DB_DATABASE=railway
DB_USERNAME=root
DB_PASSWORD=${{MySQL.MYSQL_ROOT_PASSWORD}}
SESSION_DRIVER=database
SESSION_LIFETIME=120
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
```

## How Railway Service References Work:

When you connect services in Railway, you can reference them using:
- `${{ServiceName.VARIABLE_NAME}}`
- Or use Railway's automatic variables like `${{RAILWAY_PRIVATE_DOMAIN}}`

## Best Practice:

1. **First try**: Use `${{MySQL.MYSQLHOST}}` format
2. **If that doesn't work**: Use direct values from MySQL service variables
3. **For password**: Use `${{MySQL.MYSQL_ROOT_PASSWORD}}` or the actual password

## Steps:

1. Go to Railway Dashboard
2. Click on your **Web Service** (not MySQL)
3. Go to **Variables** tab
4. Click **"Raw Editor"**
5. Delete everything
6. Paste one of the configurations above
7. Click **"Save"**
8. Railway will redeploy automatically

## Important Notes:

- **No quotes** around values
- **APP_KEY** must be set (not empty)
- Use Railway's service references when possible (more reliable)
- If references don't work, use direct values from MySQL service

