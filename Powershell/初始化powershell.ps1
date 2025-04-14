# 初始化我的powershell环境

# 该脚本只在win下运行
if($env:OS -ne "Windows_NT") {
    Write-Host ("该脚本只在Windows下运行。")
    return
}

# $Profile是否存在，如果不存在则创建
if(!(Test-Path -Path $Profile)) {
    New-Item -ItemType File -Path $Profile -Force
}

$flag = 0
$init_text = Get-Content -Path $Profile

function 检测是否存在([string]$text) {
    # 去除$text前后的所有空格
    $text = $text.Trim()

    foreach ($line in $init_text) {
        if ($line -match '^(?!\s*#).*?' + $text) {
            return $true
        }
    }
    $flag = 1
    return $false
}

function 检测Profile最后一行是否空() {
    # 如果文件不为空，并且最后一行不是空行，则添加一个空行
    if ($init_text.Count -gt 0 -and $init_text[-1].Trim() -ne "") {
        Add-Content -Path $Profile -Value ""
    }
}

# 将where.exe设置一个默认别名为which
# 检测是否存在"Set-Alias which"
if(!(检测是否存在('Set-Alias\s+which'))) {
    检测Profile最后一行是否空
    Add-Content -Path $Profile -Value '# 将where.exe设置一个默认别名为which'
    Add-Content -Path $Profile -Value 'Set-Alias which where.exe'
    Add-Content -Path $Profile -Value ''

    Write-Host ("已将where.exe设置一个默认别名为which")
    $flag = 1
}

# 输出最后的提示语
if ($flag -eq 0) {
    Write-Host "未修改任何内容。"
}
else {
    Write-Host "请重新打开Powershell窗口生效。"
}

echo ""
cmd /c pause