@REM 恢复win10/win11桌面图标默认间距的办法

@echo off
chcp 936 >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v IconSpacing /t REG_SZ /d -1125 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v IconVerticalSpacing /t REG_SZ /d -1125 /f