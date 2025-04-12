# 初始化我的powershell环境

if (-not (Test-Path $PROFILE)) {
    New-Item -Type File -Path $PROFILE -Force
}

#如果不在windows下
if ($env:OS -ne "Windows_NT") {
    Write-Host "该脚本仅在windows下有效"
    return
}
$flag = 0

# 将where.exe设置一个默认别名为which
if(!(Get-Content -Path $Profile | Select-String -Pattern "Set-Alias which")) {
    Add-Content -Path $Profile -Value @"
# 将where.exe设置一个默认别名为which
Set-Alias which where.exe

"@
    Write-Host ("已将where.exe设置一个默认别名为which")
    $flag = 1
}

# 如果安装了git，就将git的bash设置一个默认别名为bash
# 并且没有安装wsl、cygwin等其他bash
# if(!(Get-Content -Path $Profile | Select-String -Pattern "Set-Alias bash")) {
#     $gitPath = (Get-Command git).Source
#     if ($gitPath -eq $null) {
#         Write-Host "未找到git的安装路径"
#         return
#     }
#     $bashPath = $gitPath -replace "cmd\git.exe", "bin\bash.exe"
#     if (Test-Path $bashPath) {
#         Add-Content -Path $Profile -Value @"
# # 将git的bash设置一个默认别名为bash
# Set-Alias bash `"$bashPath`"

# "@
#         Write-Host ("已将git的bash设置一个默认别名为bash")
#         $flag = 1
#     } else {
#         Write-Host "未找到git的bash路径"
#     }
# }



# 输出最后的提示语
if ($flag -eq 0) {
    Write-Host "未修改任何内容。"
}
else {
    Write-Host "请重新打开Powershell窗口生效。"
}