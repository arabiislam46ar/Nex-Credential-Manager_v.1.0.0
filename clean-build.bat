@echo off
echo ============================================
echo Clean Build Folder
echo ============================================
echo.
echo This will delete the dist folder and all build files
echo.
pause

echo.
echo [1/3] Closing any running Electron instances...
taskkill /F /IM electron.exe 2>nul
taskkill /F /IM app-builder.exe 2>nul
timeout /t 2 /nobreak >nul
echo Done!

echo.
echo [2/3] Waiting for file locks to release...
timeout /t 3 /nobreak >nul

echo.
echo [3/3] Removing dist folder...
if exist dist (
    echo Attempting normal delete...
    rmdir /s /q dist 2>nul
    
    REM Check if still exists
    if exist dist (
        echo Still locked. Trying force delete...
        rd /s /q dist 2>nul
        timeout /t 2 /nobreak >nul
    )
    
    REM Final check
    if exist dist (
        echo.
        echo WARNING: Could not delete dist folder completely.
        echo Some files may be locked by:
        echo - Antivirus software
        echo - Windows Defender
        echo - File Explorer
        echo.
        echo Solutions:
        echo 1. Close all File Explorer windows
        echo 2. Temporarily disable antivirus
        echo 3. Restart computer and try again
        echo 4. Delete manually from File Explorer
        echo.
    ) else (
        echo.
        echo SUCCESS! dist folder cleaned successfully!
        echo You can now run: npm run build:win
        echo.
    )
) else (
    echo dist folder does not exist. Nothing to clean!
)

echo.
pause
