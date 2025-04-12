@REM 解决windows图标空白问题

taskkill /f /im explorer.exe
cd /d %localappdata%
del IconCache.db /a
start explorer.exe