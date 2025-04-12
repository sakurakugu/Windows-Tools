# 在UTF-8格式下，如系统语言为英文等，无法正常显示中文，可使用此脚本解决
# todo：该脚本仅在windows下有效？

# $Profile是否存在，如果不存在则创建
if(!(Test-Path -Path $Profile)) {
    New-Item -ItemType File -Path $Profile -Force
}

function 检测是否要添加() {
    # 如果本身编码为936，则不需要添加
    if ($Host.UI.RawUI.Encoding.CodePage -eq 936) {
        Write-Host ("PowerShell $printInfo" + "本身就为中文GB2312编码，无需重复设置。")
        return $false
    }
    # 检测 "chcp 936" 是否存在，如果不存在则添加
    if ((!(Get-Content -Path $Profile | Select-String -Pattern "chcp 936"))) {
        Write-Host ("PowerShell $printInfo" + "已设置为UTF-8编码下显示中文，无需重复设置。")
        return $true
    } else {
        return $false
    }
}

# 检测 "chcp 936" 是否存在，如果不存在则添加
if (检测是否要添加) {
    $versionInfo = ""
    $printInfo = ""
    if ($Host.Version.Major -ge 7) {
        $versionInfo = "# 设置PowerShell 7在系统为UTF-8编码下显示中文"
        $printInfo = PowerShell $($PSVersionTable.PSVersion)
    } else {
        $versionInfo = "# 设置PowerShell 5在系
        统为UTF-8编码下显示中文"
        $printInfo = PowerShell $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)
    }

    $profileContent = @"
$versionInfo
chcp 936
Write-Host "$([char]27)[1A$([char]27)[K$([char]27)[1A" -NoNewline

"@

    Add-Content -Path $Profile -Value $profileContent


    # 输出提示
    Write-Host ("已将PowerShell $printInfo" + "已设置为UTF-8编码下显示中文，请重新打开Powershell窗口生效。")
}
else {
    # 输出提示
    Write-Host ("PowerShell $printInfo" + "已设置为UTF-8编码下显示中文，无需重复设置。")
}