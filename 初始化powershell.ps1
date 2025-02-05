# 初始化我的powershell环境

if (-not (Test-Path $PROFILE)) {
    New-Item -Type File -Path $PROFILE -Force
}

#如果在windows下
if ($env:OS -ne "Windows_NT") {
    Write-Host "该脚本仅在windows下有效"
    return
}
$flag = 0
# 如果当前编码是UTF-8，就将其改为GBK
if (!(Get-Content -Path $Profile | Select-String -Pattern "chcp 936")) {
    Add-Content $PROFILE @"
# 设置Powershell在系统为UTF-8编码下显示中文
chcp 936
Clear-Host

"@
    Write-Host ("已将PowerShell " + (Get-Host | Select-Object -ExpandProperty Version).ToString() + "已设置为UTF-8编码下显示中文")
    flag = 1
}
# 将where.exe设置一个默认别名为which
if(!(Get-Content -Path $Profile | Select-String -Pattern "Set-Alias which where.exe")) {
    Add-Content -Path $Profile -Value @"
# 将where.exe设置一个默认别名为which
Set-Alias which where.exe

"@
    Write-Host ("已将where.exe设置一个默认别名为which")
    flag = 1
}

# 输出最后的提示语
if ($flag -eq 0) {
    Write-Host "请重新打开Powershell窗口生效。"
}
else {
    Write-Host "已全部设置，未修改任何内容。"
}