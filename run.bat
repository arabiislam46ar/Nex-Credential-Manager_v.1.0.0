@echo off
echo ============================================
echo Nex Credentials Manager
echo ============================================
echo.

REM Check if node_modules exists
if not exist node_modules (
    echo Dependencies not installed!
    echo.
    echo Installing dependencies...
    call npm install
    echo.
)

echo Starting Nex Credentials Manager...
echo.
call npm start
