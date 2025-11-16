# Fix Database Seeding Issue

## What I Just Fixed

I updated `start.sh` to:
1. ✅ Handle quotes in `SEED_DATABASE` variable (removes quotes automatically)
2. ✅ Handle case-insensitive values (`true`, `True`, `TRUE`)
3. ✅ Add debug output to show the actual value

## Step 1: Check Railway Logs

1. Go to **Railway Dashboard** → **Web Service** → **Logs**
2. Look for these messages:
   - `"Seeding database..."` = ✅ Seeding is running
   - `"Skipping database seeding..."` = ❌ Seeding is NOT running
   - `"Current SEED_DATABASE value: '...'"` = Shows what value Railway sees

## Step 2: Verify Variable Format

Go to **Railway Dashboard** → **Web Service** → **Variables**

### Option A: Remove Quotes (Recommended)

In Railway's Raw Editor, make sure `SEED_DATABASE` has **NO quotes**:

```env
SEED_DATABASE=true
```

**NOT:**
```env
SEED_DATABASE="true"  ❌
```

### Option B: Keep Quotes (Now Works)

The updated script now handles quotes, so `SEED_DATABASE="true"` should also work.

## Step 3: Trigger Redeploy

After fixing the variable:

1. **Option A:** Wait for automatic redeploy (if you changed variables)
2. **Option B:** Manually redeploy:
   - Go to **Deployments** tab
   - Click **"Redeploy"** on the latest deployment

## Step 4: Check Logs Again

After redeploy, check logs for:
- ✅ `"Seeding database..."`
- ✅ Database seeding output
- ✅ `"Seeded: 301 users, 20 employers, 100 jobs"`

## Common Issues

### Issue 1: Variable Not Set
**Symptom:** Logs show `"Skipping database seeding"`
**Fix:** Add `SEED_DATABASE=true` to Railway variables

### Issue 2: Quotes in Value
**Symptom:** Variable is `SEED_DATABASE="true"` (with quotes)
**Fix:** Remove quotes OR the updated script should handle it now

### Issue 3: Wrong Value
**Symptom:** Variable is `SEED_DATABASE=false` or empty
**Fix:** Change to `SEED_DATABASE=true`

### Issue 4: Deployment Didn't Run Script
**Symptom:** No logs about seeding at all
**Fix:** Check if `start.sh` is being called (should see migration logs)

## Quick Fix

1. **Go to Railway Variables**
2. **Set:** `SEED_DATABASE=true` (no quotes)
3. **Save** (triggers redeploy)
4. **Wait 2-3 minutes**
5. **Check logs** for seeding messages

## After Seeding Works

Once you see data in your app, you can:
- Remove `SEED_DATABASE` variable, or
- Set it to `SEED_DATABASE=false`

This prevents re-seeding on every deploy.

