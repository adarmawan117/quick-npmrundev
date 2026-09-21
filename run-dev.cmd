@echo off
setlocal EnableDelayedExpansion
title Run Dev - React / Next.js Launcher

:: Berpindah ke folder target yang diklik kanan
if not "%~1"=="" (
    cd /d "%~1"
)

echo.
echo  ==============================================================
echo    React / Next.js Development Server Launcher
echo  ==============================================================
echo  Direktori: %CD%
echo.

:: 1. Validasi keberadaan file package.json
if not exist "package.json" (
    echo  ==============================================================
    echo  [ERROR] BUKAN FOLDER PROJECT WEB / REACT!
    echo  ==============================================================
    echo  File 'package.json' tidak ditemukan di folder ini:
    echo  "%CD%"
    echo.
    echo  Tombol 'Run Dev' hanya dapat digunakan pada folder project
    echo  React, Next.js, atau Node.js.
    echo  ==============================================================
    echo.
    pause
    exit /b 1
)

:: 2. Validasi apakah project ini menggunakan React atau Next.js
findstr /i "react" "package.json" >nul 2>&1
set "HAS_REACT=%errorlevel%"
findstr /i "next" "package.json" >nul 2>&1
set "HAS_NEXT=%errorlevel%"

if %HAS_REACT% neq 0 if %HAS_NEXT% neq 0 (
    echo  ==============================================================
    echo  [ERROR] REACT.JS / NEXT.JS TIDAK TERDAFTAR DI PROJECT INI!
    echo  ==============================================================
    echo  File 'package.json' ditemukan, tetapi tidak ada library 'react'
    echo  atau 'next' di dalam daftar dependencies.
    echo.
    echo  Silakan pasang React terlebih dahulu dengan perintah:
    echo    npm install react react-dom
    echo  ==============================================================
    echo.
    pause
    exit /b 1
)

:: 3. Periksa apakah dependencies sudah diinstall (node_modules)
if not exist "node_modules" (
    echo  [INFO] Folder 'node_modules' belum ditemukan.
    echo  Menjalankan instalasi dependensi otomatis terlebih dahulu...
    echo  --------------------------------------------------------------
    if exist "pnpm-lock.yaml" (
        call pnpm install
    ) else if exist "yarn.lock" (
        call yarn install
    ) else if exist "bun.lockb" (
        call bun install
    ) else (
        call npm install
    )
    echo.
)

:: 4. Deteksi Package Manager & jalankan dev server
echo  Menjalankan Development Server...
echo  --------------------------------------------------------------
if exist "pnpm-lock.yaml" (
    echo  Package Manager : pnpm
    echo  Perintah        : pnpm dev
    echo  --------------------------------------------------------------
    echo.
    call pnpm dev
) else if exist "yarn.lock" (
    echo  Package Manager : yarn
    echo  Perintah        : yarn dev
    echo  --------------------------------------------------------------
    echo.
    call yarn dev
) else if exist "bun.lockb" (
    echo  Package Manager : bun
    echo  Perintah        : bun dev
    echo  --------------------------------------------------------------
    echo.
    call bun dev
) else (
    echo  Package Manager : npm
    echo  Perintah        : npm run dev
    echo  --------------------------------------------------------------
    echo.
    call npm run dev
)

if %errorlevel% neq 0 (
    echo.
    echo  ==============================================================
    echo  [INFO] Server telah dihentikan atau terjadi error di atas.
    echo  ==============================================================
    echo.
    pause
)
