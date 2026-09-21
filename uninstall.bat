@echo off
title Uninstall Shortcut Run Dev
echo ================================================================
echo   MENGHAPUS SHORTCUT RUN DEV DARI WINDOWS EXPLORER
echo ================================================================
echo.

reg delete "HKCU\Software\Classes\Directory\shell\RunDev" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Directory\Background\shell\RunDev" /f >nul 2>&1

echo [*] Entri registry RunDev berhasil dibersihkan.
echo.
echo ================================================================
echo [SUKSES] Shortcut 'Run Dev' telah berhasil dicopot dari Explorer!
echo ================================================================
echo.
pause
