@REM ��ݷ�ʽȥ���Ǳ�

@echo off
chcp 936 >nul

@REM ������ԱȨ��
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ��ǰû�й���ԱȨ�ޣ���ʹ�á��Թ���Ա������С������˽ű���
    pause
    exit /B 1
)

@REM ȥ����ݷ�ʽ�Ǳ�
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
taskkill /f /im explorer.exe
attrib -s -r -h "%localappdata%\iconcache.db"
del "%localappdata%\iconcache.db" /f /q
start explorer
echo ��ȥ����ݷ�ʽ�Ǳ�
echo.
pause