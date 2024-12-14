@REM 该脚本用于允许运行ps1脚本

@echo off
@REM  输出原先的执行策略
powershell -Command "$策略=Get-ExecutionPolicy -Scope CurrentUser;echo \"原先的执行策略：$策略\""
@REM powershell -Command "echo '原先的执行策略：'; Get-ExecutionPolicy -Scope CurrentUser"
@REM 设置当前的执行策略
powershell -Command Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
@REM 查看当前的执行策略
powershell -Command "$策略=Get-ExecutionPolicy -Scope CurrentUser;echo \"已修改执行策略`n当前的执行策略：$策略`n\""

pause