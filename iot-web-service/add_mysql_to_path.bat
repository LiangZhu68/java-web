@echo off
echo.
echo 正在添加MySQL到系统PATH...
echo.

REM 临时添加到当前会话
set "PATH=%PATH%;C:\mysql-9.5.0-winx64\bin"

REM 永久添加到系统PATH（需要管理员权限）
echo 设置系统环境变量...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path | findstr /i "C:\\mysql-9.5.0-winx64\\bin"
if %ERRORLEVEL% neq 0 (
    echo 添加MySQL到系统PATH...
    REM 获取当前PATH
    for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do (
        set "OLDPATH=%%b"
    )
    REM 添加MySQL路径
    set "NEWPATH=%OLDPATH%;C:\mysql-9.5.0-winx64\bin"
    REM 更新注册表
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%NEWPATH%" /f
    echo 已更新系统PATH，请重新启动命令提示符或重启计算机使更改生效。
) else (
    echo MySQL路径已存在于系统PATH中
)

echo.
echo 完成。当前会话PATH已更新。
echo.
pause