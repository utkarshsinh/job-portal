# Job Portal Application

A full-featured job board application built with Laravel 11. This application allows employers to create and manage job postings, while job seekers can browse jobs, apply for positions, and track their applications.

## Features

* **User Authentication** - Secure registration and login system
* **Job Postings** - Employers can create, edit, and manage job listings with details like:
  - Job title, description, and salary range
  - Location and category
  - Experience level required
* **Job Applications** - Users can apply to jobs with expected salary information
* **Employer Management** - Company profiles linked to user accounts
* **Application Tracking** - Users can view and manage their job applications
* **Search & Filter** - Filter jobs by salary, experience level, category, and location

## Technologies Used

* **Laravel 11** - PHP framework
* **PHP 8.2+** - Programming language
* **SQLite** - Database (can be easily switched to MySQL/PostgreSQL)
* **Tailwind CSS** - Styling
* **Alpine.js** - JavaScript framework
* **Vite** - Build tool

## Prerequisites

- PHP 8.2 or higher
- Composer
- Node.js and npm
- SQLite (included with PHP) or MySQL/PostgreSQL

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/utkarshsinh/job-portal.git
   cd job-portal
   ```

2. **Install PHP dependencies:**
   ```bash
   composer install
   ```

3. **Install Node.js dependencies:**
   ```bash
   npm install
   ```

4. **Set up environment file:**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

5. **Configure database:**
   
   The project is configured to use SQLite by default. The database file will be created automatically.
   
   If you want to use MySQL or PostgreSQL instead, update your `.env` file:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=job_board
   DB_USERNAME=root
   DB_PASSWORD=your_password
   ```

6. **Create database file (for SQLite):**
   ```bash
   touch database/database.sqlite
   ```

7. **Run migrations:**
   ```bash
   php artisan migrate
   ```

8. **Seed the database (optional - adds sample data):**
   ```bash
   php artisan db:seed
   ```
   
   This will create:
   - 301 users (including test user: `utkarshsinh96@gmail.com` / `password`)
   - 20 employers
   - 100 job postings
   - 571 job applications

9. **Build frontend assets:**
   ```bash
   npm run build
   ```

10. **Start the development server:**
    ```bash
    php artisan serve
    ```

    Visit `http://localhost:8000` in your browser.

## Development

### Running with Hot Reload

For frontend development with hot module replacement:

```bash
# Terminal 1: Laravel server
php artisan serve

# Terminal 2: Vite dev server
npm run dev
```

Or use the composer script to run both:

```bash
composer run dev
```

### Viewing Database

You can view the database using:

1. **DB Browser for SQLite** (recommended):
   ```bash
   brew install --cask db-browser-for-sqlite
   ```
   Then open `database/database.sqlite`

2. **Laravel Tinker:**
   ```bash
   php artisan tinker
   ```
   ```php
   User::all();
   Job::all();
   ```

3. **SQLite CLI:**
   ```bash
   sqlite3 database/database.sqlite
   ```

## Project Structure

```
job-board/
├── app/
│   ├── Http/
│   │   ├── Controllers/     # Application controllers
│   │   ├── Middleware/      # Custom middleware
│   │   └── Requests/        # Form request validation
│   ├── Models/              # Eloquent models
│   ├── Policies/            # Authorization policies
│   └── View/                # View components
├── database/
│   ├── factories/           # Model factories for seeding
│   ├── migrations/          # Database migrations
│   └── seeders/             # Database seeders
├── resources/
│   ├── views/               # Blade templates
│   ├── css/                 # Stylesheets
│   └── js/                  # JavaScript files
└── routes/
    └── web.php              # Application routes
```

## Default Login Credentials

After seeding, you can log in with:
- **Email:** `utkarshsinh96@gmail.com`
- **Password:** `password`

(All seeded users have the password: `password`)

## Routes

- `/` or `/jobs` - Browse all job postings
- `/jobs/{id}` - View job details
- `/login` - Login/Register page
- `/my-job-applications` - View your applications (requires login)
- `/employer/create` - Create employer profile (requires login)
- `/my-jobs` - Manage job postings (requires employer account)

## Database Tables

- `users` - User accounts
- `employers` - Company/employer profiles
- `offered_jobs` - Job postings
- `job_applications` - Job applications

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
