# Railway MySQL Configuration

## Environment Variables for Your Web Service

Go to your **Web Service** → **Variables** tab in Railway and add these:

### Required Variables:

```env
APP_NAME="Job Portal"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-app-name.up.railway.app

# Database Configuration (MySQL)
DB_CONNECTION=mysql
DB_HOST=${{MySQL.MYSQLHOST}}
DB_PORT=${{MySQL.MYSQLPORT}}
DB_DATABASE=${{MySQL.MYSQL_DATABASE}}
DB_USERNAME=${{MySQL.MYSQLUSER}}
DB_PASSWORD=${{MySQL.MYSQLPASSWORD}}

# Or use direct values (if Railway variables don't work):
# DB_CONNECTION=mysql
# DB_HOST=mysql.railway.internal
# DB_PORT=3306
# DB_DATABASE=railway
# DB_USERNAME=root
# DB_PASSWORD=nnNsEbvqMoOouNUqJDnbbToULeLbQBJi

# Session
SESSION_DRIVER=database
SESSION_LIFETIME=120

# Cache
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
```

## How to Add Variables in Railway:

1. Go to your **Web Service** (not the MySQL service)
2. Click on **Variables** tab
3. Click **+ New Variable**
4. Add each variable one by one, OR
5. Click **Raw Editor** and paste all at once

## Using Railway's Auto Variables:

Railway provides automatic variables for connected services. Try using:
- `${{MySQL.MYSQLHOST}}` instead of `mysql.railway.internal`
- `${{MySQL.MYSQLPORT}}` instead of `3306`
- `${{MySQL.MYSQL_DATABASE}}` instead of `railway`
- `${{MySQL.MYSQLUSER}}` instead of `root`
- `${{MySQL.MYSQLPASSWORD}}` instead of the password

If those don't work, use the direct values shown above.

## After Setting Variables:

1. Railway will automatically redeploy
2. Or manually trigger a redeploy
3. Check logs to ensure database connection works
4. Run migrations: `railway run php artisan migrate --force`

## Test Database Connection:

After deployment, check logs for any database connection errors. If you see errors, verify:
- All DB_ variables are set correctly
- MySQL service is running in Railway
- No typos in variable names

