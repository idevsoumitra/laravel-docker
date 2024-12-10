<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;
Route::get('/', function () {
    return view('welcome');
});

Route::get('/migrate', function () {
    \Illuminate\Support\Facades\Artisan::call('migrate:refresh --force');
    return response()->json(['message' => 'Migrations run successfully!']);
});

Route::get('/create-database/{name}', function ($name) {
    try {
        DB::statement("CREATE DATABASE $name");

        return "Database '$name' created successfully!";
    } catch (\Exception $e) {
        return "Error: " . $e->getMessage();
    }
});
