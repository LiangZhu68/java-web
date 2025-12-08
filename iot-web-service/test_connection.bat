@echo off
echo.
echo 测试数据库连接...
echo.

echo 正在测试数据库连接...
mysql -u root -p040608 -e "USE book; SHOW TABLES;"
if %ERRORLEVEL% equ 0 (
    echo 数据库连接测试成功！
    echo.
    echo 可用表：
    mysql -u root -p040608 -e "USE book; SHOW TABLES;"
) else (
    echo 数据库连接测试失败。
    echo 请确保：
    echo 1. MySQL服务正在运行
    echo 2. 密码正确（040608）
    echo 3. 'book' 数据库已创建
)

echo.
echo 测试完成。
pause