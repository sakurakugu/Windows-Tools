# 在UTF-8格式下，如系统语言为英文等，无法正常显示中文，可使用此脚本解决

# $Profile是否存在，如果不存在则创建
if(!(Test-Path -Path $Profile)) {
    New-Item -ItemType File -Path $Profile -Force
}

# 检测 "chcp 936" 是否存在，如果不存在则添加
if(!(Get-Content -Path $Profile | Select-String -Pattern "chcp 936")) {
    Add-Content -Path $Profile -Value @"
# 设置Powershell在系统为UTF-8编码下显示中文
chcp 936
Clear-Host
"@
    # 输出提示
    Write-Host ("已将PowerShell " + (Get-Host | Select-Object -ExpandProperty Version).ToString() + "设置为UTF-8编码下显示中文，请重新打开Powershell窗口生效。")
}
else {
    # 输出提示
    Write-Host ("PowerShell " + (Get-Host | Select-Object -ExpandProperty Version).ToString() + "已设置为UTF-8编码下显示中文，无需重复设置。")
}