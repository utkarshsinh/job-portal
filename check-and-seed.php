<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "Starting database check and seed process...\n";

try {
    require __DIR__.'/vendor/autoload.php';
    echo "✓ Autoloader loaded\n";
    
    $app = require_once __DIR__.'/bootstrap/app.php';
    echo "✓ Application bootstrapped\n";
    
    $app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();
    echo "✓ Console kernel bootstrapped\n";
    
    use App\Models\User;
    use App\Models\Job;
    use App\Models\Employer;
    
    // Check database connection
    try {
        \DB::connection()->getPdo();
        echo "✓ Database connection successful\n";
    } catch (\Exception $e) {
        echo "✗ Database connection failed: " . $e->getMessage() . "\n";
        exit(1);
    }
    
    $userCount = User::count();
    $jobCount = Job::count();
    $employerCount = Employer::count();
    
    echo "Current database state: users=$userCount, jobs=$jobCount, employers=$employerCount\n";
    
    // Seed if any of the core tables are empty.
    if ($userCount === 0 || $jobCount === 0 || $employerCount === 0) {
        echo "Database appears incomplete. Starting seeding...\n";
        
        try {
            $exitCode = \Artisan::call('db:seed', ['--force' => true]);
            
            if ($exitCode === 0) {
                // Verify seeding worked
                $newUserCount = User::count();
                $newJobCount = Job::count();
                $newEmployerCount = Employer::count();
                
                echo "✓ Seeding completed with exit code: $exitCode\n";
                echo "New database state: users=$newUserCount, jobs=$newJobCount, employers=$newEmployerCount\n";
                
                if ($newUserCount > 0 && $newJobCount > 0 && $newEmployerCount > 0) {
                    echo "✓ Database seeded successfully!\n";
                } else {
                    echo "⚠ Warning: Seeding completed but some tables are still empty!\n";
                }
            } else {
                echo "✗ Seeding failed with exit code: $exitCode\n";
                exit(1);
            }
        } catch (\Exception $e) {
            echo "✗ Error during seeding: " . $e->getMessage() . "\n";
            echo "Stack trace: " . $e->getTraceAsString() . "\n";
            exit(1);
        }
    } else {
        echo "✓ Database already has data. Skipping seeding.\n";
    }
    
    exit(0);
} catch (\Exception $e) {
    echo "✗ Fatal error: " . $e->getMessage() . "\n";
    echo "Stack trace: " . $e->getTraceAsString() . "\n";
    exit(1);
}
