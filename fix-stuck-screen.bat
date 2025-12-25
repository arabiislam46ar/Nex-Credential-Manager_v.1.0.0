@echo off
echo ============================================
echo Nex Credentials Manager - Fix Stuck Screen
echo ============================================
echo.
echo This will reset the app by deleting config files
echo Your credentials will be safe!
echo.
pause

echo.
echo [1/2] Closing any running instances...
taskkill /F /IM electron.exe 2>nul
echo Done!

echo.
echo [2/2] Deleting config file...
set APPDATA_PATH=%APPDATA%\nex-credentials-manager
if exist "%APPDATA_PATH%\config.json" (
    del "%APPDATA_PATH%\config.json"
    echo Config deleted successfully!
) else (
    echo Config file not found - may already be clean
)

echo.
echo ============================================
echo Fix Complete!
echo ============================================
echo.
echo Now run: npm start
echo.
echo The app will ask you to create a new Master PIN
echo.
pause
