@REM ��ݷ�ʽ�ָ��Ǳ�

@echo off
chcp 936 >nul

@REM ������ԱȨ��
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ��ǰû�й���ԱȨ�ޣ���ʹ�á��Թ���Ա������С������˽ű���
    pause
    exit /B 1
)

@REM �ָ���ݷ�ʽ�Ǳ�
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f
taskkill /f /im explorer.exe
attrib -s -r -h "%localappdata%\iconcache.db"
del "%localappdata%\iconcache.db" /f /q
start explorer
echo �ѻָ���ݷ�ʽ�Ǳ�
echo.
pause