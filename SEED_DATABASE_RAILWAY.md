# How to Seed Database on Railway

## Option 1: Automatic Seeding (One-Time)

I can update `railway.json` to seed automatically on first deploy. This will run seeders once when you set a flag.

### Update Railway Variables:

Add this variable in Railway Dashboard → Web Service → Variables:

```env
SEED_DATABASE=true
```

Then update `railway.json` to check this flag and seed if needed.

---

## Option 2: Manual Seeding via Railway Dashboard

If Railway has a "Run Command" or "Shell" feature:

1. Go to Railway Dashboard → Web Service
2. Look for "Command" or "Shell" option
3. Run: `php artisan db:seed`

---

## Option 3: Add to Start Command (Runs Every Deploy - Not Recommended)

We can add seeding to the start command, but this would run every time you deploy (not ideal).

---

## Option 4: Create a Seeder Script

Create a script that runs seeders, then trigger it manually when needed.

---

## Recommendation: Option 1 (Automatic with Flag)

I'll set it up so:
- Set `SEED_DATABASE=true` in Railway variables
- On next deploy, it will seed automatically
- After seeding, you can remove the flag

This way you control when to seed!

