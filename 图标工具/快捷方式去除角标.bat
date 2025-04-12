@REM 快捷方式去除角标

@echo off
chcp 936 >nul

@REM 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 当前没有管理员权限，请使用“以管理员身份运行”启动此脚本。
    pause
    exit /B 1
)

@REM 去除快捷方式角标
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
taskkill /f /im explorer.exe
attrib -s -r -h "%localappdata%\iconcache.db"
del "%localappdata%\iconcache.db" /f /q
start explorer
echo 已去除快捷方式角标
echo.
pause