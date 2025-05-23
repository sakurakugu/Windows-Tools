# 在UTF-8格式下，或系统语言为英文等，无法正常显示中文，可使用此脚本解决

# 该脚本只在win下运行
if($env:OS -ne "Windows_NT") {
    Write-Host ("该脚本只在Windows下运行。")
    return
}

# 获取当前版本信息
$ps_Info = ""
if ($Host.Version.Major -ge 7) {
    $ps_Info = "PowerShell "+$($PSVersionTable.PSVersion)
} else {
    $ps_Info = "PowerShell "+$($PSVersionTable.PSVersion.Major)+"."+$($PSVersionTable.PSVersion.Minor)
}

# $Profile是否存在，如果不存在则创建
if(!(Test-Path -Path $Profile)) {
    New-Item -ItemType File -Path $Profile -Force
}

function 检测是否要添加() {
    # 如果本身编码为936，则不需要设置
    if ([Console]::OutputEncoding.CodePage -eq 936) {
        Write-Host ("$ps_Info" + "本身就为中文GB2312编码，无需重复设置。")
        return $false
    }

    function 检测是否已设置() {
        foreach ($line in Get-Content -Path $Profile) {
            if ($line -match '^(?!\s*#).*?\[Console\]::OutputEncoding\s*=\s*\[System\.Text\.Encoding\]::GetEncoding\(\s*"gb2312"\s*\)') {
                return $true
            }
        }
        return $false
    }

    if (检测是否已设置) {
        Write-Host ("$ps_Info" + "已设置为使用中文GB2312编码，无需重复设置。")
        return $false
    } else {
        return $true
    }
}

function 检测Profile最后一行是否空() {
    $lines = Get-Content -Path $Profile
    # 如果文件不为空，并且最后一行不是空行，则添加一个空行
    if ($lines.Count -gt 0 -and $lines[-1].Trim() -ne "") {
        Add-Content -Path $Profile -Value ""
    }
}

# 检测 "chcp 936" 是否存在，如果不存在则添加
if (检测是否要添加) {
    $versionInfo = "# 设置"+$ps_Info+"在系统为UTF-8编码下显示中文"
    $profileContent = "[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(`"gb2312`")"

    检测Profile最后一行是否空
    Add-Content -Path $Profile -Value $versionInfo
    Add-Content -Path $Profile -Value $profileContent
    Add-Content -Path $Profile -Value ""

    Write-Host ("已将 $ps_Info" + "设置为使用中文GB2312编码，请重新打开Powershell窗口生效。")
}

echo ""
cmd /c pause