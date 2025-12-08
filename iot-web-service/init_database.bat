@echo off
echo.
echo 初始化MySQL数据库...
echo.

REM 检查MySQL是否正在运行
net start | findstr /i "mysql"
if %ERRORLEVEL% neq 0 (
    echo MySQL服务未运行，请启动MySQL服务后再运行此脚本。
    pause
    exit /b 1
)

echo 连接到MySQL并创建数据库...
mysql -u root -p040608 -e "CREATE DATABASE IF NOT EXISTS book CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
if %ERRORLEVEL% neq 0 (
    echo 数据库创建失败，请检查MySQL连接和密码。
    pause
    exit /b 1
)

echo 导入数据库结构和数据...
mysql -u root -p040608 book < "C:\Users\liangzhu\Documents\GitHub\java-web\iot-web-service\database.sql"
if %ERRORLEVEL% neq 0 (
    echo 数据库导入失败。
    pause
    exit /b 1
)

echo.
echo 数据库初始化完成！
echo 数据库 'book' 已创建并导入了表结构和初始数据。
echo.

pause