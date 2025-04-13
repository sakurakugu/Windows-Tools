# win10等没试过，理论上也可以用

# 接受一个字符 y是添加，n是取消，d是删除(默认)，x是关闭，其他是无效
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
# 提示语
$tip = "是否开关Win11搜索栏网页搜索功能？(y=开启/n=关闭)"
# 判断注册表路径是否存在，不存在则创建
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}
# 判断用户输入

# 读取用户输入，并转换为小写
$choice = (Read-Host -Prompt $tip).ToLower()
if ($choice -eq "y") {
    # 添加
    Remove-ItemProperty -Path $regPath -Name "BingSearchEnabled" -ErrorAction SilentlyContinue
    Write-Host "开启成功"
} elseif ($choice -eq "n") {
    # 取消
    Set-ItemProperty -Path $regPath -Name "BingSearchEnabled" -Value 0 -Type DWORD
    Write-Host "关闭成功"
}

echo ""
cmd /c pause
