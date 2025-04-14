@REM 该脚本用于允许运行ps1脚本
@echo off
chcp 936 >nul

@REM 输出原先的执行策略，设置当前的执行策略，查看当前的执行策略
powershell -Command ^
    "$policy = Get-ExecutionPolicy -Scope CurrentUser; " ^
    "Write-Output (\"原先的执行策略：\" + $policy); " ^
    "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; " ^
    "$policy = Get-ExecutionPolicy -Scope CurrentUser; " ^
    "Write-Output (\"已修改执行策略`n当前的执行策略：\" + $policy + \"`n\")"

pause