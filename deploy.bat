@echo off
setlocal

cd /d "%~dp0"

echo.
echo === Deploy metals-guide to github.com/mtimuru-bit/metals ===
echo.

if not exist ".git" (
    echo [1/4] First run - initializing git...
    git init -b main
    git remote add origin https://github.com/mtimuru-bit/metals.git
    set FIRST_RUN=1
) else (
    echo [1/4] Git already initialized.
    set FIRST_RUN=0
)

echo.
echo [2/4] Staging files...
git add -A

echo.
echo [3/4] Committing...
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm"') do set TS=%%i
git commit -m "Update %TS%"

echo.
echo [4/4] Pushing to GitHub...
if "%FIRST_RUN%"=="1" (
    echo     WARNING: first push will overwrite existing repo files.
    pause
    git push -u origin main --force
) else (
    git push
)

echo.
echo === Done! In ~1 minute updated at: ===
echo     https://mtimuru-bit.github.io/metals/
echo.
pause
