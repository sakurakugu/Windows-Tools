@REM �ýű�������������ps1�ű�
@echo off
chcp 936 >nul

@REM ���ԭ�ȵ�ִ�в��ԣ����õ�ǰ��ִ�в��ԣ��鿴��ǰ��ִ�в���
powershell -Command ^
    "$policy = Get-ExecutionPolicy -Scope CurrentUser; " ^
    "Write-Output (\"ԭ�ȵ�ִ�в��ԣ�\" + $policy); " ^
    "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; " ^
    "$policy = Get-ExecutionPolicy -Scope CurrentUser; " ^
    "Write-Output (\"���޸�ִ�в���`n��ǰ��ִ�в��ԣ�\" + $policy + \"`n\")"

pause