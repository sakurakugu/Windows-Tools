# 检查是否启用了 Hyper-V
Write-Host "`n正在检测 Hyper-V 状态..." -ForegroundColor Cyan

try {
    $hvFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
    if ($hvFeature.State -eq "Enabled") {
        Write-Host "`n✅ Hyper-V 已启用。" -ForegroundColor Green
    } elseif ($hvFeature.State -eq "Disabled") {
        Write-Host "❌ Hyper-V 未启用。" -ForegroundColor Red

        # 询问用户是否启用 Hyper-V
        $choice = Read-Host "是否现在启用 Hyper-V？(Y/N)"

        if ($choice -match '^[Yy]$') {
            Write-Host "`n正在启用 Hyper-V..." -ForegroundColor Yellow

            # 启用 Hyper-V 功能
            Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

            Write-Host "`n✅ Hyper-V 已启用成功，但需要重启才能生效。" -ForegroundColor Green
            $restart = Read-Host "是否现在重启电脑？(Y/N)"
            if ($restart -match '^[Yy]$') {
                Restart-Computer
            } else {
                Write-Host "请稍后手动重启电脑以完成设置。" -ForegroundColor Yellow
            }
        } else {
            Write-Host "未启用 Hyper-V。" -ForegroundColor Yellow
        }
    } else {
        Write-Host "`n⚠️ 无法确定 Hyper-V 状态：$($hvFeature.State)" -ForegroundColor Red
    }
} catch {
    Write-Host "`n❌ 检测 Hyper-V 状态失败，请以管理员身份运行此脚本。" -ForegroundColor Red
}

# 检查系统是否运行在 Hypervisor 上
$hypervisorPresent = (Get-CimInstance Win32_ComputerSystem).HypervisorPresent
if ($hypervisorPresent) {
    Write-Host "`n✅ 当前系统正在运行在 Hypervisor 上。" -ForegroundColor Green
} else {
    Write-Host "`n⚠️ 系统未检测到 Hypervisor，可能需要在 BIOS 中启用虚拟化（VT-x / AMD-V）。" -ForegroundColor Yellow
}

# Read-Host -Prompt "`n按任意键退出"