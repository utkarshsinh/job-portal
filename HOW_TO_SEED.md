# How to Seed Database on Railway

## ✅ Automatic Seeding (Recommended)

I've created a startup script that seeds automatically when you set a flag.

### Step 1: Add Seeding Flag

1. **Go to Railway Dashboard** → Web Service → Variables
2. **Add this variable:**
   ```
   SEED_DATABASE=true
   ```
3. **Save** (Railway will redeploy automatically)

### Step 2: After Deployment

Railway will automatically:
1. ✅ Run migrations (create tables)
2. ✅ Run seeders (add data) - because `SEED_DATABASE=true`
3. ✅ Start the server

### Step 3: After Seeding is Done

Once you have data, you can **remove** the `SEED_DATABASE` variable (or set it to `false`) so it doesn't seed on every deploy.

---

## What Gets Seeded

When you run `php artisan db:seed`, it creates:
- ✅ 301 users (including `utkarshsinh96@gmail.com`)
- ✅ 20 employers
- ✅ 100 job postings
- ✅ ~571 job applications

---

## Quick Steps:

1. **Add to Railway Variables:**
   ```
   SEED_DATABASE=true
   ```

2. **Wait for redeploy** (2-3 minutes)

3. **Check your app** - should have data now!

4. **Remove the flag** after first seeding (optional, to prevent re-seeding on future deploys)

---

## How It Works

- `start.sh` script runs on every deploy
- It checks if `SEED_DATABASE=true` is set
- If yes → runs seeders
- If no → skips seeding
- Then starts the server

This gives you full control over when to seed!

