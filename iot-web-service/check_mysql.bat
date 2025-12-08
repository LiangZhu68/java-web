@echo off
chcp 65001 >nul
echo.
echo 检查系统中MySQL安装状态...
echo.

REM 检查MySQL命令是否存在
where mysql
if %ERRORLEVEL% == 0 (
    echo MySQL命令行工具已安装
    mysql --version
) else (
    echo MySQL命令行工具未安装或不在PATH中
)

echo.
REM 检查MySQL服务
echo 检查MySQL服务...
sc query ^| findstr /i mysql
if %ERRORLEVEL% EQU 0 (
    echo 找到MySQL服务
) else (
    echo 未找到MySQL服务
)

echo.
REM 检查可能的MySQL安装目录
echo 检查可能的MySQL安装目录...
if exist "C:\Program Files\MySQL" (
    echo MySQL安装目录存在: C:\Program Files\MySQL
    dir "C:\Program Files\MySQL" /AD
) else (
    echo MySQL安装目录不存在: C:\Program Files\MySQL
)

if exist "C:\ProgramData\MySQL" (
    echo MySQL数据目录存在: C:\ProgramData\MySQL
) else (
    echo MySQL数据目录不存在: C:\ProgramData\MySQL
)

echo.
echo 检查完成。
pause