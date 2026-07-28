@echo off
cd /d "%~dp0"

echo ============================================
echo           RoGen - Install Dependencies
echo ============================================
echo.

REM Check if Python is installed
py --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not found!
    echo Please install Python from https://www.python.org/downloads/
    echo.
    echo IMPORTANT: Install Python 3.11 for best compatibility!
    echo Make sure to check "Add Python to PATH" during installation!
    echo.
    pause
    exit /b 1
)

echo [OK] Python found!
py --version
echo.

REM Check Python version compatibility
py -c "import sys; exit(0 if (sys.version_info.major == 3 and 9 <= sys.version_info.minor <= 12) else 1)" >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Your Python version may have compatibility issues!
    echo RoGen works best with Python 3.9, 3.10, 3.11, or 3.12.
    echo Python 3.13+ may have issues with some dependencies.
    echo Consider installing Python 3.11 from https://www.python.org/downloads/
    echo.
    set /p continue="Do you want to continue anyway? (y/n): "
    if /i not "%continue%"=="y" exit /b 1
    echo.
)

echo Upgrading pip...
py -m pip install --upgrade pip

echo.
echo Installing dependencies from requirements.txt...
echo.
py -m pip install -r "requirements.txt"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to install dependencies!
    echo.
    echo COMMON FIXES:
    echo 1. Make sure you have Python 3.9-3.12 installed (Python 3.11 recommended)
    echo 2. Download Python 3.11 from: https://www.python.org/downloads/
    echo 3. Try running: py -m pip install --upgrade pip
    echo 4. Then try again: install.bat
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
echo       Installation Complete!
echo ============================================
echo.
echo You can now run start.bat or run.bat to launch RoGen.
echo.
pause