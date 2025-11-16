# Debugging CSS/Assets Not Loading

## What I Just Fixed

I moved `npm run build` from the `install` phase to the `build` phase in `nixpacks.toml`. This ensures assets are built at the right time.

## How to Check if Build is Working

### Step 1: Check Railway Build Logs

1. Go to Railway Dashboard → Web Service → Deployments
2. Click on the latest deployment
3. Check the build logs for:
   - ✅ `npm ci` - should install dependencies
   - ✅ `npm run build` - should compile assets
   - ✅ `ls -la public/build` - should show built files

### Step 2: Verify Build Output

Look for these in the build logs:
```
✓ built in XXXms
```

And check if `public/build` directory has files:
- `public/build/.vite/manifest.json` (required!)
- `public/build/assets/*.css`
- `public/build/assets/*.js`

### Step 3: Check Application Logs

If build succeeds but CSS still doesn't load:
1. Go to Railway → Web Service → Logs
2. Look for errors related to:
   - Asset loading
   - Vite manifest
   - 404 errors for CSS/JS files

## Common Issues

### Issue 1: Build Fails Silently
**Symptom:** No errors in logs, but no CSS
**Fix:** Check if `npm run build` actually runs and completes

### Issue 2: Manifest File Missing
**Symptom:** CSS/JS return 404
**Fix:** Ensure `public/build/.vite/manifest.json` exists after build

### Issue 3: Wrong APP_ENV
**Symptom:** Assets not loading
**Fix:** Ensure `APP_ENV=production` in Railway variables

### Issue 4: Build Directory Not Writable
**Symptom:** Build fails with permission errors
**Fix:** The `mkdir -p public/build` should handle this

## Quick Test

After the next deployment, check Railway logs for:
1. ✅ `npm run build` completes successfully
2. ✅ `public/build/.vite/manifest.json` exists
3. ✅ No 404 errors for CSS/JS in application logs

## If Still Not Working

1. **Check Railway build logs** - share the relevant section
2. **Check application logs** - look for asset-related errors
3. **Verify environment variables** - ensure `APP_ENV=production`

## Alternative: Pre-build Assets Locally

If Railway build keeps failing, you can:
1. Run `npm run build` locally
2. Commit `public/build` directory (temporarily remove from `.gitignore`)
3. Push to Railway

But this is not recommended for production - better to fix the build process.

