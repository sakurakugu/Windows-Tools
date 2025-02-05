@REM 该脚本用于允许运行ps1脚本

@echo off

powershell -Command ^
" ^
$策略=Get-ExecutionPolicy -Scope CurrentUser; ^
echo \"原先的执行策略：$策略\"; ^
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; ^
$策略=Get-ExecutionPolicy -Scope CurrentUser; ^
echo \"已修改执行策略`n当前的执行策略：$策略`n\";  ^
"

pause