@REM �ָ�win10/win11����ͼ��Ĭ�ϼ��İ취

@echo off
chcp 936 >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v IconSpacing /t REG_SZ /d -1125 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v IconVerticalSpacing /t REG_SZ /d -1125 /f