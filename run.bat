@echo off
cd /d "%~dp0"

echo ============================================
echo           RoGen - Setup and Launch
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
    echo Continuing anyway...
    echo.
)

REM Check if dependencies are already installed
echo Checking for required dependencies...
py -c "import PySimpleGUI; import PIL; import matplotlib; import numpy" >nul 2>&1
if %errorlevel% neq 0 (
    echo Dependencies not found or incomplete. Installing now...
    echo.
    py -m pip install --upgrade pip
    py -m pip install -r "requirements.txt"
    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Failed to install dependencies!
        echo.
        echo COMMON FIXES:
        echo 1. Try running install.bat manually first
        echo 2. Make sure you have Python 3.9-3.12 installed (Python 3.11 recommended)
        echo 3. Download Python 3.11 from: https://www.python.org/downloads/
        echo.
        pause
        exit /b 1
    )
    echo.
    echo [OK] Dependencies installed successfully!
) else (
    echo [OK] All dependencies already installed!
)

echo.
echo ============================================
echo              Starting RoGen GUI
echo ============================================
echo.

py "main\gui.py"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to start the GUI!
    echo Please check the error messages above.
    echo.
    pause
)
