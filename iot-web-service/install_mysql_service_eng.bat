@echo off
echo.
echo Initializing MySQL data directory...
echo.

REM Check if running as administrator
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Error: Please run this script as administrator
    pause
    exit /b 1
)

echo Running MySQL data directory initialization...
"C:\mysql-9.5.0-winx64\bin\mysqld" --defaults-file="C:\Users\liangzhu\Documents\GitHub\java-web\iot-web-service\my.ini" --initialize --console --user=root

if %ERRORLEVEL% neq 0 (
    echo MySQL data directory initialization failed
    pause
    exit /b 1
)

echo.
echo Data directory initialization complete!
echo Temporary password is displayed above, please note the root user temporary password
echo.

echo Installing MySQL as Windows service...
"C:\mysql-9.5.0-winx64\bin\mysqld" --install MySQL95 --defaults-file="C:\Users\liangzhu\Documents\GitHub\java-web\iot-web-service\my.ini"

if %ERRORLEVEL% neq 0 (
    echo Failed to install MySQL service
    pause
    exit /b 1
)

echo.
echo MySQL service installed as MySQL95
echo Starting MySQL service...
net start MySQL95

if %ERRORLEVEL% neq 0 (
    echo Failed to start MySQL service
    pause
    exit /b 1
)

echo.
echo MySQL service started successfully!
echo.
echo Please use the following command to login for the first time and change the password:
echo mysql -u root -p
echo.
echo Then run ALTER USER 'root'@'localhost' IDENTIFIED BY '040608';
echo.

pause