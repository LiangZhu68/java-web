@echo off
echo.
echo Checking MySQL installation status...
echo.

echo Looking for MySQL in PATH...
where mysql
if %ERRORLEVEL% == 0 (
    echo MySQL command line tool found
    mysql --version
) else (
    echo MySQL command line tool not found in PATH
)

echo.
echo Checking for MySQL services...
sc query | findstr /i mysql
if %ERRORLEVEL% == 0 (
    echo Found MySQL service
) else (
    echo No MySQL service found
)

echo.
echo Checking common MySQL installation directories...
if exist "C:\Program Files\MySQL" (
    echo MySQL directory exists: C:\Program Files\MySQL
    dir "C:\Program Files\MySQL" /AD
) else (
    echo MySQL directory does not exist: C:\Program Files\MySQL
)

if exist "C:\ProgramData\MySQL" (
    echo MySQL data directory exists: C:\ProgramData\MySQL
) else (
    echo MySQL data directory does not exist: C:\ProgramData\MySQL
)

if exist "C:\mysql-8.0.28" (
    echo MySQL old directory exists: C:\mysql-8.0.28
) else (
    echo MySQL old directory does not exist: C:\mysql-8.0.28
)

echo.
echo Check completed.
pause