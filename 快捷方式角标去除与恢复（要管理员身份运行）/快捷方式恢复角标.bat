@REM 快捷方式恢复角标

@echo off
chcp 936 >nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f
taskkill /f /im explorer.exe
attrib -s -r -h "%localappdata%\iconcache.db"
del "%localappdata%\iconcache.db" /f /q
start explorer