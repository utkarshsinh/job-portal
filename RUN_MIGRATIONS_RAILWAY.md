# Run Migrations on Railway Using CLI

## Step 1: Install Railway CLI

```bash
npm i -g @railway/cli
```

## Step 2: Login to Railway

```bash
railway login
```

This will open your browser to authenticate.

## Step 3: Link to Your Project

```bash
railway link
```

Select your project when prompted.

## Step 4: Run Migrations

```bash
railway run php artisan migrate --force
```

This will run all migrations on Railway's MySQL database.

## Step 5: Seed Database (Optional)

```bash
railway run php artisan db:seed
```

## That's It!

After running migrations, your app should work!

Visit: https://web-production-cab50.up.railway.app

