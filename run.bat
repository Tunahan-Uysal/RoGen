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
    echo Make sure to check "Add Python to PATH" during installation!
    echo.
    pause
    exit /b 1
)

echo [OK] Python found!
echo.

REM Check if dependencies are already installed
echo Checking for required dependencies...
py -c "import PySimpleGUI; import PIL; import matplotlib" >nul 2>&1
if %errorlevel% neq 0 (
    echo Dependencies not found. Installing now...
    echo.
    py -m pip install --upgrade pip
    py -m pip install -r "requirements.txt"
    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Failed to install dependencies!
        echo Please try running install.bat manually first.
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
