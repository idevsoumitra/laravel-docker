<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/migrate', function () {
    \Illuminate\Support\Facades\Artisan::call('migrate:refresh --force');
    return response()->json(['message' => 'Migrations run successfully!']);
});
