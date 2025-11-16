# Deployment Guide for Job Portal Application

## Pre-Deployment Checklist

Before deploying, make sure to:

1. **Switch from SQLite to MySQL/PostgreSQL** (SQLite is not recommended for production)
2. **Update `.env` for production**
3. **Build frontend assets**
4. **Set up proper file permissions**
5. **Configure domain/SSL**

---

## Deployment Options

### Option 1: Platform-as-a-Service (PaaS) - Easiest

#### 1.1 Laravel Forge ⭐ (Recommended for Laravel)
**Best for:** Laravel-specific hosting with easy setup

**Steps:**
1. Sign up at [forge.laravel.com](https://forge.laravel.com)
2. Connect your GitHub repository
3. Create a new server (DigitalOcean, AWS, Linode, etc.)
4. Deploy your site
5. Forge handles: Nginx, SSL, PHP, Composer, etc.

**Cost:** ~$12/month + server costs (~$5-10/month)

#### 1.2 Vercel / Netlify
**Best for:** Static sites (not ideal for Laravel, but possible with serverless)

**Note:** Requires significant configuration for Laravel

#### 1.3 Railway
**Best for:** Quick deployments with database included

**Steps:**
1. Sign up at [railway.app](https://railway.app)
2. Connect GitHub repo
3. Add MySQL/PostgreSQL service
4. Set environment variables
5. Deploy

**Cost:** ~$5-20/month (pay-as-you-go)

#### 1.4 Render
**Best for:** Simple deployments

**Steps:**
1. Sign up at [render.com](https://render.com)
2. Create new Web Service
3. Connect GitHub repo
4. Add PostgreSQL database
5. Configure build and start commands:
   - Build: `composer install --no-dev && npm install && npm run build`
   - Start: `php artisan serve --host=0.0.0.0 --port=$PORT`

**Cost:** Free tier available, paid plans start at $7/month

#### 1.5 Fly.io
**Best for:** Global deployment

**Steps:**
1. Install Fly CLI: `curl -L https://fly.io/install.sh | sh`
2. Run: `fly launch`
3. Configure database
4. Deploy: `fly deploy`

**Cost:** Free tier available

---

### Option 2: Traditional VPS Deployment

#### 2.1 DigitalOcean / Linode / Vultr
**Best for:** Full control, learning experience

**Requirements:**
- VPS (Ubuntu 22.04 recommended)
- Domain name (optional but recommended)
- SSH access

**Steps:**

1. **Connect to server:**
   ```bash
   ssh root@your-server-ip
   ```

2. **Install dependencies:**
   ```bash
   # Update system
   apt update && apt upgrade -y
   
   # Install PHP 8.2
   apt install -y php8.2-fpm php8.2-cli php8.2-mysql php8.2-xml php8.2-mbstring php8.2-curl php8.2-zip
   
   # Install Composer
   curl -sS https://getcomposer.org/installer | php
   mv composer.phar /usr/local/bin/composer
   
   # Install Nginx
   apt install -y nginx
   
   # Install MySQL
   apt install -y mysql-server
   
   # Install Node.js
   curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
   apt install -y nodejs
   ```

3. **Clone and setup project:**
   ```bash
   cd /var/www
   git clone https://github.com/utkarshsinh/job-portal.git
   cd job-portal
   
   # Install dependencies
   composer install --no-dev --optimize-autoloader
   npm install
   npm run build
   
   # Setup environment
   cp .env.example .env
   nano .env  # Edit with production values
   php artisan key:generate
   ```

4. **Configure database:**
   ```bash
   mysql -u root -p
   CREATE DATABASE job_portal;
   CREATE USER 'job_user'@'localhost' IDENTIFIED BY 'strong_password';
   GRANT ALL PRIVILEGES ON job_portal.* TO 'job_user'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   ```

5. **Update `.env`:**
   ```env
   APP_ENV=production
   APP_DEBUG=false
   APP_URL=https://yourdomain.com
   
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=job_portal
   DB_USERNAME=job_user
   DB_PASSWORD=strong_password
   ```

6. **Run migrations:**
   ```bash
   php artisan migrate --force
   php artisan db:seed  # Optional
   ```

7. **Set permissions:**
   ```bash
   chown -R www-data:www-data /var/www/job-portal
   chmod -R 755 /var/www/job-portal
   chmod -R 775 /var/www/job-portal/storage
   chmod -R 775 /var/www/job-portal/bootstrap/cache
   ```

8. **Configure Nginx:**
   ```bash
   nano /etc/nginx/sites-available/job-portal
   ```

   Add this configuration:
   ```nginx
   server {
       listen 80;
       server_name yourdomain.com www.yourdomain.com;
       root /var/www/job-portal/public;

       add_header X-Frame-Options "SAMEORIGIN";
       add_header X-Content-Type-Options "nosniff";

       index index.php;

       charset utf-8;

       location / {
           try_files $uri $uri/ /index.php?$query_string;
       }

       location = /favicon.ico { access_log off; log_not_found off; }
       location = /robots.txt  { access_log off; log_not_found off; }

       error_page 404 /index.php;

       location ~ \.php$ {
           fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
           fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
           include fastcgi_params;
       }

       location ~ /\.(?!well-known).* {
           deny all;
       }
   }
   ```

   Enable site:
   ```bash
   ln -s /etc/nginx/sites-available/job-portal /etc/nginx/sites-enabled/
   nginx -t
   systemctl reload nginx
   ```

9. **Setup SSL with Let's Encrypt:**
   ```bash
   apt install -y certbot python3-certbot-nginx
   certbot --nginx -d yourdomain.com -d www.yourdomain.com
   ```

10. **Setup Supervisor for Queue (if needed):**
    ```bash
    nano /etc/supervisor/conf.d/job-portal-worker.conf
    ```
    
    Add:
    ```ini
    [program:job-portal-worker]
    process_name=%(program_name)s_%(process_num)02d
    command=php /var/www/job-portal/artisan queue:work --sleep=3 --tries=3
    autostart=true
    autorestart=true
    user=www-data
    numprocs=1
    redirect_stderr=true
    stdout_logfile=/var/www/job-portal/storage/logs/worker.log
    ```
    
    ```bash
    supervisorctl reread
    supervisorctl update
    supervisorctl start job-portal-worker:*
    ```

**Cost:** ~$5-12/month for VPS

---

### Option 3: Cloud Platforms

#### 3.1 AWS (EC2 + RDS)
**Best for:** Scalable, enterprise applications

**Services needed:**
- EC2 instance (server)
- RDS (MySQL/PostgreSQL database)
- S3 (for file storage)
- CloudFront (CDN, optional)

**Cost:** ~$20-50/month minimum

#### 3.2 Google Cloud Platform
**Best for:** Integration with Google services

**Services:**
- Compute Engine (VM)
- Cloud SQL (database)
- Cloud Storage

**Cost:** ~$20-50/month minimum

#### 3.3 Azure
**Best for:** Microsoft ecosystem integration

**Services:**
- App Service or VM
- Azure Database for MySQL

**Cost:** ~$20-50/month minimum

---

## Production Environment Variables

Update your `.env` file with these production settings:

```env
APP_NAME="Job Portal"
APP_ENV=production
APP_KEY=base64:your-generated-key
APP_DEBUG=false
APP_URL=https://yourdomain.com

LOG_CHANNEL=stack
LOG_LEVEL=error

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=job_portal
DB_USERNAME=your_db_user
DB_PASSWORD=your_strong_password

SESSION_DRIVER=database
SESSION_LIFETIME=120

CACHE_DRIVER=file
QUEUE_CONNECTION=database

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=your_mail_username
MAIL_PASSWORD=your_mail_password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@yourdomain.com
MAIL_FROM_NAME="${APP_NAME}"
```

---

## Deployment Commands

### Before deploying:

```bash
# Install production dependencies
composer install --no-dev --optimize-autoloader

# Build frontend assets
npm install
npm run build

# Clear and cache config
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run migrations
php artisan migrate --force
```

### After deployment:

```bash
# Clear all caches
php artisan optimize:clear

# Rebuild caches
php artisan optimize
```

---

## Quick Deploy Scripts

### For VPS Deployment:

Create `deploy.sh`:
```bash
#!/bin/bash

cd /var/www/job-portal

# Pull latest code
git pull origin master

# Install dependencies
composer install --no-dev --optimize-autoloader
npm install
npm run build

# Run migrations
php artisan migrate --force

# Clear and cache
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Restart services
php artisan optimize:clear
php artisan optimize

echo "Deployment complete!"
```

Make it executable:
```bash
chmod +x deploy.sh
```

---

## Recommended: Start with Railway or Render

For beginners, I recommend starting with **Railway** or **Render** because:
- ✅ Easy setup (connects to GitHub)
- ✅ Database included
- ✅ SSL/HTTPS automatic
- ✅ Free tier available
- ✅ No server management needed

---

## Important Notes

1. **Never commit `.env` file** - It's already in `.gitignore`
2. **Use MySQL/PostgreSQL in production** - SQLite is for development only
3. **Enable HTTPS** - Use Let's Encrypt (free SSL)
4. **Set proper file permissions** - Storage and cache directories need write access
5. **Configure queue workers** - If using queues, set up Supervisor
6. **Set up backups** - Regular database backups are essential
7. **Monitor logs** - Check `storage/logs/laravel.log` for errors

---

## Need Help?

- Laravel Documentation: https://laravel.com/docs/deployment
- Laravel Forge: https://forge.laravel.com
- DigitalOcean Tutorial: https://www.digitalocean.com/community/tutorials/how-to-deploy-a-laravel-application-with-nginx-on-ubuntu

