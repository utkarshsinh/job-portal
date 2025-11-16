# How to View Data in Railway MySQL Database

## Option 1: Railway Dashboard (Easiest)

Railway provides a database viewer in the dashboard:

1. **Go to Railway Dashboard**
2. **Click on your MySQL service** (not the web service)
3. **Look for "Data" or "Database" tab**
4. **Click "Open in Browser" or "View Data"**
5. You'll see all tables and can browse data

---

## Option 2: Use MySQL Client (TablePlus, MySQL Workbench, etc.)

### Get Connection Details from Railway:

1. **Go to Railway Dashboard**
2. **Click MySQL service**
3. **Go to "Variables" tab**
4. **Find these values**:
   - Host: `MYSQLHOST` (or use `MYSQL_PUBLIC_URL`)
   - Port: `MYSQLPORT` (usually 3306)
   - Database: `MYSQL_DATABASE` (railway)
   - Username: `MYSQLUSER` (root)
   - Password: `MYSQL_ROOT_PASSWORD`

### Connect Using TablePlus (Recommended):

1. **Install TablePlus**: https://tableplus.com/
2. **Open TablePlus**
3. **Click "Create a new connection"**
4. **Select MySQL**
5. **Enter connection details**:
   - Host: Use the public URL from Railway (like `caboose.proxy.rlwy.net`)
   - Port: From Railway variables (like `27186`)
   - User: `root`
   - Password: `nnNsEbvqMoOouNUqJDnbbToULeLbQBJi`
   - Database: `railway`
6. **Click Connect**

### Or Use MySQL Public URL:

Railway provides `MYSQL_PUBLIC_URL`:
```
mysql://root:nnNsEbvqMoOouNUqJDnbbToULeLbQBJi@caboose.proxy.rlwy.net:27186/railway
```

You can use this connection string in any MySQL client.

---

## Option 3: Railway CLI (Command Line)

If you have Railway CLI installed:

```bash
# Connect to MySQL via Railway
railway connect mysql
```

This will give you a MySQL command line interface.

---

## Option 4: Use Laravel Tinker (Via Railway)

If you can run commands on Railway:

```bash
railway run php artisan tinker
```

Then in Tinker:
```php
// View all users
User::all();

// View all jobs
Job::all();

// View all employers
Employer::all();

// Count records
User::count();
Job::count();
```

---

## Option 5: Use DB Browser for MySQL

If you have DB Browser installed, you can connect using:
- Connection string from Railway
- Or individual connection parameters

---

## Quick Access: Railway Dashboard

**Easiest way**: Railway Dashboard → MySQL Service → Data/Query tab

Many Railway setups include a built-in database viewer where you can:
- Browse tables
- View data
- Run SQL queries
- Export data

---

## What Tables You'll See:

Once migrations are run, you'll see:
- `users` - User accounts
- `offered_jobs` - Job postings
- `employers` - Companies
- `job_applications` - Applications
- `sessions` - User sessions (if using database sessions)
- `migrations` - Migration history
- `cache` - Cache data
- `cache_locks` - Cache locks

---

## Check if Data Exists:

If tables are empty, you need to:
1. Run migrations: `php artisan migrate --force`
2. Seed data: `php artisan db:seed`

Then you'll see data in the tables!

