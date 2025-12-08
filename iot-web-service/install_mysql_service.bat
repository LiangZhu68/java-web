@echo off
echo.
echo 正在配置MySQL 9.5.0...
echo.

REM 检查是否以管理员身份运行
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 错误: 请以管理员身份运行此脚本
    pause
    exit /b 1
)

echo 正在初始化MySQL数据目录...
"C:\mysql-9.5.0-winx64\bin\mysqld" --defaults-file="C:\Users\liangzhu\Documents\GitHub\java-web\iot-web-service\my.ini" --initialize --console --user=root

if %ERRORLEVEL% neq 0 (
    echo MySQL数据目录初始化失败
    pause
    exit /b 1
)

echo.
echo 数据目录初始化完成！
echo 临时密码已显示在上面，请记下root用户的临时密码
echo.

echo 安装MySQL为Windows服务...
"C:\mysql-9.5.0-winx64\bin\mysqld" --install MySQL95 --defaults-file="C:\Users\liangzhu\Documents\GitHub\java-web\iot-web-service\my.ini"

if %ERRORLEVEL% neq 0 (
    echo 安装MySQL服务失败
    pause
    exit /b 1
)

echo.
echo MySQL服务已安装为 MySQL95
echo 正在启动MySQL服务...
net start MySQL95

if %ERRORLEVEL% neq 0 (
    echo 启动MySQL服务失败
    pause
    exit /b 1
)

echo.
echo MySQL服务已成功启动！
echo.
echo 请使用以下命令首次登录并更改密码：
echo mysql -u root -p
echo.
echo 然后运行 ALTER USER 'root'@'localhost' IDENTIFIED BY '040608';
echo.

pause