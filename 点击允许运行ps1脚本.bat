@REM 该脚本用于允许运行ps1脚本

@echo off
chcp 65001 > nul
powershell -Command ^
" ^
$OutputEncoding = [Console]::OutputEncoding = [Text.Encoding]::UTF8; ^
$celve=Get-ExecutionPolicy -Scope CurrentUser; ^
Write-Output (\"原先的执行策略：$celve\"); ^
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; ^
$celve=Get-ExecutionPolicy -Scope CurrentUser; ^
Write-Output (\"已修改执行策略`n当前的执行策略：$celve`n\");  ^
"

pause

