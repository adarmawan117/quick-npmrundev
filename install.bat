@echo off
setlocal EnableDelayedExpansion
title Installer Shortcut Run Dev Context Menu
echo ================================================================
echo      INSTALLER SHORTCUT RUN DEV WINDOWS EXPLORER
echo ================================================================
echo.

:: 1. Cek apakah Node.js terpasang
where node.exe >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js BELUM TERINSTALL DI KOMPUTER INI!
    echo.
    echo Library React.js dan Next.js membutuhkan runtime Node.js agar
    echo dapat dijalankan.
    echo.
    echo Silakan download dan pasang Node.js terlebih dahulu di:
    echo https://nodejs.org/
    echo.
    echo Pemasangan shortcut Run Dev DIBATALKAN.
    echo ================================================================
    echo.
    pause
    exit /b 1
)

:: 2. Cek apakah npm terpasang
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] NPM Node Package Manager TIDAK DITEMUKAN!
    echo.
    echo Pastikan Node.js dan npm telah terdaftar pada PATH Windows Anda.
    echo Pemasangan shortcut Run Dev DIBATALKAN.
    echo ================================================================
    echo.
    pause
    exit /b 1
)

echo [*] Pengecekan Sistem:
for /f "tokens=*" %%v in ('node -v 2^>nul') do echo     - Node.js terdeteksi : %%v
for /f "tokens=*" %%v in ('npm -v 2^>nul') do echo     - npm terdeteksi     : v%%v

:: 3. Deteksi otomatis Windows Terminal wt.exe vs Command Prompt cmd.exe
where wt.exe >nul 2>&1
if %errorlevel% equ 0 (
    set "USE_WT=1"
    set "TERM_NAME=Windows Terminal [wt.exe]"
) else (
    set "USE_WT=0"
    set "TERM_NAME=Command Prompt [cmd.exe]"
)
echo     - Terminal otomatis  : %TERM_NAME%
echo.

:: 4. Siapkan folder icon dan script permanen di profil pengguna
set "TARGET_DIR=%USERPROFILE%\.icons"
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
)

:: 5. Salin icon dan runner script ke folder pengguna
copy /y "%~dp0react.ico" "%TARGET_DIR%\react.ico" >nul
copy /y "%~dp0run-dev.cmd" "%TARGET_DIR%\run-dev.cmd" >nul

if not exist "%TARGET_DIR%\react.ico" (
    echo [!] Peringatan: Gagal menyalin react.ico
)
if not exist "%TARGET_DIR%\run-dev.cmd" (
    echo [!] Peringatan: Gagal menyalin run-dev.cmd
)

:: 6. Format path untuk file Registry (ubah \ menjadi \\)
set "REG_ICON=%TARGET_DIR%\react.ico"
set "REG_ICON=%REG_ICON:\=\\%"

set "REG_SCRIPT=%TARGET_DIR%\run-dev.cmd"
set "REG_SCRIPT=%REG_SCRIPT:\=\\%"

:: 7. Buat file .reg temporary untuk didaftarkan
set "TEMP_REG=%TEMP%\rundev_install.reg"

(
echo Windows Registry Editor Version 5.00
echo.
echo [HKEY_CURRENT_USER\Software\Classes\Directory\shell\RunDev]
echo @="Run Dev"
echo "Icon"="%REG_ICON%"
echo.
echo [HKEY_CURRENT_USER\Software\Classes\Directory\shell\RunDev\command]
if "%USE_WT%"=="1" (
    echo @="wt.exe -d \"%%1\" \"%REG_SCRIPT%\" \"%%1\""
) else (
    echo @="cmd.exe /k call \"%REG_SCRIPT%\" \"%%1\""
)
echo.
echo [HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\RunDev]
echo @="Run Dev"
echo "Icon"="%REG_ICON%"
echo.
echo [HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\RunDev\command]
if "%USE_WT%"=="1" (
    echo @="wt.exe -d \"%%V\" \"%REG_SCRIPT%\" \"%%V\""
) else (
    echo @="cmd.exe /k call \"%REG_SCRIPT%\" \"%%V\""
)
) > "%TEMP_REG%"

:: 8. Daftarkan ke Windows Registry
reg import "%TEMP_REG%" >nul
set "REG_STATUS=%errorlevel%"
del "%TEMP_REG%" >nul 2>&1

echo ================================================================
if %REG_STATUS% equ 0 (
    echo [SUKSES] Shortcut Run Dev berhasil dipasang ke Windows Explorer!
    echo.
    echo Detail Konfigurasi:
    echo - Icon React          : %TARGET_DIR%\react.ico
    echo - Runner Script       : %TARGET_DIR%\run-dev.cmd
    echo - Terminal Default    : %TERM_NAME%
    echo.
    echo Cara Penggunaan:
    echo 1. Buka File Explorer di folder mana saja.
    echo 2. Klik kanan pada folder project React/Next.js, pilih Run Dev.
    echo    Atau masuk ke dalam folder, klik kanan di ruang kosong.
    echo 3. Dev server akan otomatis berjalan!
    echo    Jika bukan folder React/Next.js, akan muncul notifikasi ramah.
) else (
    echo [GAGAL] Terjadi kesalahan saat menulis ke Windows Registry.
)
echo ================================================================
echo.
pause
