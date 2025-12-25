@echo off
title Nex Credentials Manager - Complete Build Process
color 0A

echo.
echo ========================================================
echo    NEX CREDENTIALS MANAGER - COMPLETE BUILD PROCESS
echo ========================================================
echo.
echo This script will:
echo  1. Close all Electron processes
echo  2. Clean dist folder completely
echo  3. Build Windows installer
echo.
echo IMPORTANT: Run this as Administrator for best results!
echo.
echo ========================================================
pause

REM ============================================
REM STEP 1: Close Processes
REM ============================================
echo.
echo [STEP 1/5] Closing running processes...
echo.

taskkill /F /IM electron.exe 2>nul
if %errorlevel% equ 0 (
    echo - Electron closed
) else (
    echo - No Electron process found
)

taskkill /F /IM app-builder.exe 2>nul
if %errorlevel% equ 0 (
    echo - App Builder closed
) else (
    echo - No App Builder process found
)

echo.
echo Waiting for processes to fully terminate...
timeout /t 3 /nobreak >nul
echo Done!

REM ============================================
REM STEP 2: Clean Cache
REM ============================================
echo.
echo [STEP 2/5] Cleaning electron-builder cache...
echo.

set CACHE_DIR=%LOCALAPPDATA%\electron-builder\Cache
if exist "%CACHE_DIR%" (
    echo Removing cache: %CACHE_DIR%
    rmdir /s /q "%CACHE_DIR%" 2>nul
    if %errorlevel% equ 0 (
        echo - Cache cleaned successfully!
    ) else (
        echo - Warning: Could not clean cache (not critical)
    )
) else (
    echo - No cache found to clean
)

REM ============================================
REM STEP 3: Clean Dist Folder
REM ============================================
echo.
echo [STEP 3/5] Cleaning dist folder...
echo.

if exist dist (
    echo Removing dist folder...
    
    REM First attempt - normal delete
    rmdir /s /q dist 2>nul
    timeout /t 2 /nobreak >nul
    
    REM Check if deleted
    if exist dist (
        echo - First attempt failed, trying force delete...
        rd /s /q dist 2>nul
        timeout /t 2 /nobreak >nul
        
        if exist dist (
            echo.
            echo ================================================
            echo WARNING: Could not delete dist folder!
            echo ================================================
            echo.
            echo Possible causes:
            echo  - Files locked by antivirus
            echo  - File Explorer has folder open
            echo  - Insufficient permissions
            echo.
            echo Solutions:
            echo  1. Close all File Explorer windows
            echo  2. Temporarily disable antivirus
            echo  3. Delete dist folder manually
            echo  4. Restart computer and try again
            echo.
            echo ================================================
            pause
            echo.
            echo Attempting to continue anyway...
        ) else (
            echo - Force delete successful!
        )
    ) else (
        echo - Dist folder cleaned successfully!
    )
) else (
    echo - No dist folder to clean
)

REM ============================================
REM STEP 4: Verify Node/npm
REM ============================================
echo.
echo [STEP 4/5] Verifying environment...
echo.

node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed!
    echo Please install from: https://nodejs.org/
    pause
    exit /b 1
)

npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: npm is not available!
    pause
    exit /b 1
)

echo - Node.js: OK
echo - npm: OK
echo - Project folder: %CD%

REM Check if node_modules exists
if not exist node_modules (
    echo.
    echo WARNING: node_modules not found!
    echo Running npm install first...
    echo.
    call npm install
    if %errorlevel% neq 0 (
        echo.
        echo ERROR: npm install failed!
        pause
        exit /b 1
    )
)

REM ============================================
REM STEP 5: Build
REM ============================================
echo.
echo [STEP 5/5] Building Windows installer...
echo.
echo This may take 3-5 minutes depending on your computer.
echo Please be patient...
echo.
echo ========================================================

call npm run build:win

REM ============================================
REM Check Build Result
REM ============================================
echo.
echo ========================================================
echo.

if exist dist\*.exe (
    echo.
    echo  ██████╗ ██╗   ██╗ ██████╗ ██████╗███████╗███████╗███████╗
    echo ██╔════╝ ██║   ██║██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝
    echo ╚█████╗  ██║   ██║██║     ██║     █████╗  ███████╗███████╗
    echo  ╚═══██╗ ██║   ██║██║     ██║     ██╔══╝  ╚════██║╚════██║
    echo ██████╔╝ ╚██████╔╝╚██████╗╚██████╗███████╗███████║███████║
    echo ╚═════╝   ╚═════╝  ╚═════╝ ╚═════╝╚══════╝╚══════╝╚══════╝
    echo.
    echo ========================================================
    echo           BUILD COMPLETED SUCCESSFULLY!
    echo ========================================================
    echo.
    echo Installer created:
    dir dist\*.exe
    echo.
    echo Location: %CD%\dist\
    echo.
    echo You can now:
    echo  1. Install the .exe file on any Windows computer
    echo  2. Share it with others
    echo  3. Run it without Node.js installed
    echo.
    echo Opening dist folder...
    timeout /t 2 /nobreak >nul
    explorer dist
    
) else (
    echo.
    echo  ███████╗ █████╗ ██╗██╗     ███████╗██████╗ 
    echo  ██╔════╝██╔══██╗██║██║     ██╔════╝██╔══██╗
    echo  █████╗  ███████║██║██║     █████╗  ██║  ██║
    echo  ██╔══╝  ██╔══██║██║██║     ██╔══╝  ██║  ██║
    echo  ██║     ██║  ██║██║███████╗███████╗██████╔╝
    echo  ╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚═════╝ 
    echo.
    echo ========================================================
    echo              BUILD FAILED!
    echo ========================================================
    echo.
    echo Please check the error messages above.
    echo.
    echo Common solutions:
    echo  1. Run this script as Administrator
    echo  2. Close all applications and try again
    echo  3. Temporarily disable antivirus
    echo  4. Check WINDOWS_FIX.md for detailed solutions
    echo  5. Check BUILD-ERROR-FIX.md for access denied fixes
    echo.
    echo For help, check:
    echo  - BUILD-ERROR-FIX.md (Bangla)
    echo  - WINDOWS_FIX.md (English)
    echo  - আপনার-সমাধান.md (Bangla guide)
    echo.
)

echo ========================================================
echo.
pause
