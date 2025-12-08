@echo off
echo.
echo 正在卸载现有的MySQL...
echo.

REM 停止并删除MySQL服务
echo 停止MySQL服务...
net stop mysql
sc delete mysql

REM 查找并删除MySQL服务（如果存在其他MySQL服务名）
for /f "tokens=3" %%i in ('sc query ^| findstr MYSQL') do (
    net stop %%i
    sc delete %%i
)

echo.
echo 删除MySQL相关目录...
REM 删除MySQL程序目录（根据实际情况调整路径）
if exist "C:\Program Files\MySQL" rmdir /s /q "C:\Program Files\MySQL"
if exist "C:\ProgramData\MySQL" rmdir /s /q "C:\ProgramData\MySQL"
if exist "C:\mysql-8.0.28" rmdir /s /q "C:\mysql-8.0.28"

echo.
echo 检查是否卸载完成...
where mysql
if %ERRORLEVEL% == 1 (
    echo MySQL命令行工具已移除 (正常情况)
) else (
    echo MySQL命令行工具仍在PATH中，可能需要手动删除其安装目录
)

echo.
echo 卸载过程完成。
echo.
echo 请从控制面板 -> 程序和功能 中手动卸载MySQL相关程序。
echo 然后重启计算机以确保所有服务被彻底移除。
echo.
echo 重启后，再重新安装MySQL 8.0或更高版本。
echo.
echo 安装时请使用以下配置：
echo - 端口: 3306
echo - 密码: 040608
echo - 将MySQL配置为Windows服务
echo.

pause