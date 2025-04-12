@REM 解决windows图标空白问题

@echo off
chcp 936 >nul
taskkill /f /im explorer.exe
attrib -s -r -h "%localappdata%\iconcache.db"
del "%localappdata%\iconcache.db" /f /q
start explorer.exe