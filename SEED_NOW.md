# How to Seed Database on Railway

## Option 1: Automatic Seeding (Easiest)

### Step 1: Add/Verify Variable in Railway

1. Go to **Railway Dashboard** → **Web Service** → **Variables**
2. Make sure you have:
   ```
   SEED_DATABASE=true
   ```
3. If it's not there, **add it** and save
4. Railway will automatically redeploy

### Step 2: Wait for Redeploy

- Railway will detect the variable change
- It will redeploy automatically
- During deployment, `start.sh` will see `SEED_DATABASE=true` and run seeders
- Your database will be populated!

### Step 3: Verify Data

After deployment (2-3 minutes), check your app:
- Visit: https://web-production-cab50.up.railway.app
- You should see jobs, users, etc.

---

## Option 2: Manual Seeding via Railway CLI (Immediate)

If you want to seed **right now** without waiting for redeploy:

### Step 1: Install Railway CLI (if not installed)

```bash
npm i -g @railway/cli
```

### Step 2: Login and Link

```bash
railway login
railway link
# Select your Laravel service when prompted
```

### Step 3: Run Seeder

```bash
railway run php artisan db:seed
```

This will seed the database immediately!

---

## What Gets Seeded

When you run `php artisan db:seed`, it creates:
- ✅ **301 users** (including `utkarshsinh96@gmail.com` / password: `password`)
- ✅ **20 employers**
- ✅ **100 job postings**
- ✅ **~571 job applications**

---

## Quick Answer

**Easiest way:** Add `SEED_DATABASE=true` to Railway variables → Wait for redeploy → Done!

**Fastest way:** Use Railway CLI → `railway run php artisan db:seed` → Done immediately!

