@echo off
echo ============================================
echo Nex Credentials Manager - Build Script
echo ============================================
echo.
echo This script will build the Windows installer
echo Make sure to run this as Administrator!
echo.
pause

echo.
echo [1/4] Closing any running instances...
taskkill /F /IM electron.exe 2>nul
timeout /t 2 /nobreak >nul
echo Done!

echo.
echo [2/4] Cleaning old build...
if exist dist (
    echo Removing dist folder...
    rmdir /s /q dist 2>nul
    timeout /t 2 /nobreak >nul
    if exist dist (
        echo Warning: Some files might be locked. Trying force delete...
        rd /s /q dist 2>nul
        timeout /t 2 /nobreak >nul
    )
)
echo Done!

echo.
echo [3/4] Building application...
echo This may take a few minutes...
call npm run build:win

echo.
echo [4/4] Build complete!
echo.
if exist dist\*.exe (
    echo SUCCESS! Installer created in dist\ folder
    echo.
    dir dist\*.exe
    echo.
    echo Opening dist folder...
    timeout /t 2 /nobreak >nul
    explorer dist
) else (
    echo ERROR! Build failed. Check the error messages above.
    echo.
    echo Common solutions:
    echo 1. Run this script as Administrator
    echo 2. Close all Electron apps and try again
    echo 3. Delete dist folder manually and retry
    echo 4. Temporarily disable antivirus
    echo 5. Run: npm run clean
)

echo.
pause
