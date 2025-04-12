@echo off
@REM :: 检查是否以管理员权限运行
@REM net session >nul 2>&1
@REM if %errorLevel% neq 0 (
@REM     echo 请以管理员权限运行此脚本！
@REM     pause
@REM     exit /b
@REM )

@REM :: 设置 PowerShell 执行策略为 RemoteSigned
@REM echo 正在设置 PowerShell 执行策略为 RemoteSigned...
@REM powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force"

@REM :: 检查是否成功
@REM if %errorLevel% equ 0 (
@REM     echo 成功：PowerShell 执行策略已设置为 RemoteSigned。
@REM ) else (
@REM     echo 错误：无法设置 PowerShell 执行策略。
@REM )

@REM pause