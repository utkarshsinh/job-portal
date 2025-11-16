# How Laravel Gets Data - Complete Flow

## 📊 Data Flow Diagram

```
User visits website
    ↓
Route (web.php) → Controller
    ↓
Controller → Model (Job, User, etc.)
    ↓
Model → Database (MySQL on Railway)
    ↓
Database returns data
    ↓
Model → Controller
    ↓
Controller → View (Blade template)
    ↓
User sees data in browser
```

---

## 🔍 Step-by-Step: Where Data Comes From

### 1. **Database Connection** (Environment Variables)

Laravel reads database connection from Railway variables:

```env
DB_CONNECTION=mysql
DB_HOST=mysql.railway.internal
DB_DATABASE=railway
DB_USERNAME=root
DB_PASSWORD=...
```

**Location**: Railway Dashboard → Variables

**File**: `config/database.php` reads these variables

---

### 2. **Models** (Fetch Data from Database)

Models like `Job`, `User`, `Employer` connect to the database:

**Example**: `app/Models/Job.php`

```php
class Job extends Model
{
    protected $table = 'offered_jobs';  // Table name in database
    
    // This model automatically connects to MySQL database
    // and can fetch data from 'offered_jobs' table
}
```

**How it works**:
- `Job::all()` → Fetches all rows from `offered_jobs` table
- `Job::find(1)` → Fetches job with ID 1
- `Job::where('salary', '>', 50000)->get()` → Fetches jobs with salary > 50000

---

### 3. **Controllers** (Use Models to Get Data)

Controllers use Models to fetch data:

**Example**: `app/Http/Controllers/JobController.php`

```php
public function index()
{
    // This line fetches ALL jobs from database
    $jobs = Job::with('employer')->latest()->filter($filters)->get();
    
    // Pass data to view
    return view('job.index', ['jobs' => $jobs]);
}
```

**What happens**:
1. `Job::with('employer')` → Fetches jobs + related employer data
2. `latest()` → Orders by newest first
3. `filter($filters)` → Applies search/filter
4. `get()` → Executes query and returns data

---

### 4. **Database Tables** (Where Data is Stored)

Data is stored in MySQL database tables:

- `users` → User accounts
- `offered_jobs` → Job postings
- `employers` → Company information
- `job_applications` → Applications by users
- `sessions` → User sessions (if using database sessions)

**Created by**: Migrations (`database/migrations/`)

**Populated by**: Seeders (`database/seeders/DatabaseSeeder.php`)

---

### 5. **Views** (Display Data)

Views receive data from controllers and display it:

**Example**: `resources/views/job/index.blade.php`

```blade
@foreach($jobs as $job)
    <div>{{ $job->title }}</div>
    <div>{{ $job->salary }}</div>
@endforeach
```

---

## 🗄️ Current Data Sources

### **On Railway (Production)**:
- **Database**: MySQL on Railway
- **Host**: `mysql.railway.internal`
- **Database Name**: `railway`
- **Tables**: Created by migrations (when you run them)
- **Data**: Empty until you run `php artisan db:seed`

### **Locally (Development)**:
- **Database**: SQLite (`database/database.sqlite`)
- **Tables**: Already created (you ran migrations)
- **Data**: Already seeded (301 users, 100 jobs, etc.)

---

## 📝 Example: How Jobs Page Gets Data

1. **User visits**: `https://web-production-cab50.up.railway.app/jobs`

2. **Route matches**: `routes/web.php` → `JobController@index`

3. **Controller runs**:
   ```php
   Job::with('employer')->latest()->filter($filters)->get()
   ```

4. **Laravel queries database**:
   ```sql
   SELECT * FROM offered_jobs 
   JOIN employers ON offered_jobs.employer_id = employers.id
   ORDER BY created_at DESC
   ```

5. **Database returns**: All job records

6. **Controller passes to view**: `['jobs' => $jobs]`

7. **View displays**: Job listings in browser

---

## 🔑 Key Points

1. **Environment Variables** → Tell Laravel which database to use
2. **Models** → Connect to database tables
3. **Controllers** → Use Models to fetch data
4. **Database** → Stores all the actual data
5. **Migrations** → Create table structure
6. **Seeders** → Add initial/sample data

---

## 🚨 Important: Your Railway Database is Empty!

Right now, your Railway MySQL database has:
- ✅ Tables created (if migrations ran)
- ❌ **NO DATA** (until you run seeders)

That's why you need to run:
```bash
php artisan db:seed
```

This will add:
- 301 users
- 20 employers  
- 100 jobs
- 571 job applications

---

## 📍 Where to Check Data

### **Railway Database**:
- Use Railway's MySQL service dashboard
- Or connect via MySQL client using Railway's connection string

### **Local Database**:
- DB Browser for SQLite: Open `database/database.sqlite`
- Or: `sqlite3 database/database.sqlite`

---

## Summary

**Data comes from**: MySQL database on Railway (configured via environment variables)

**How it gets there**: 
1. Migrations create tables
2. Seeders add initial data
3. Users can add data through the app

**How app uses it**: Models → Controllers → Views

