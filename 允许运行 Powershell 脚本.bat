@REM 该脚本用于允许运行ps1脚本

@echo off
@REM 检测并设置字符编码
for /f "tokens=2 delims=:" %%a in ('chcp') do set cp=%%a
set cp=%cp: =%
if "%cp%"=="936" (
    chcp 936 >nul
) else (
    chcp 65001 >nul
)

@REM 输出原先的执行策略，设置当前的执行策略，查看当前的执行策略
powershell -Command ^
    "$policy = Get-ExecutionPolicy -Scope CurrentUser; " ^
    "Write-Output ('原先的执行策略：' + $policy); " ^
    "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; " ^
    "$policy = Get-ExecutionPolicy -Scope CurrentUser; " ^
    "Write-Output ('已修改执行策略' + [Environment]::NewLine + '当前的执行策略：' + $policy + [Environment]::NewLine)"

pause