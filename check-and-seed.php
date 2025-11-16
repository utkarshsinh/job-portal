<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\User;

$userCount = User::count();

if ($userCount === 0) {
    echo "Database is empty. Seeding...\n";
    \Artisan::call('db:seed', ['--force' => true]);
    echo "Database seeded successfully!\n";
    exit(0);
} else {
    echo "Database already has $userCount users. Skipping seeding.\n";
    exit(0);
}

