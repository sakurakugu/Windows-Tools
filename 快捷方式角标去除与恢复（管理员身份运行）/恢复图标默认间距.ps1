# 恢复win10/win11桌面图标默认间距的办法

# 在注册表进入路径HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics
# 找到IconSpacing和IconVerticalSpacing两个键值，双击打开，将数值改为-1125，然后点击确定。
# 如果此时还对图标显示效果不满意的话，可以尝试在桌面上按住Ctrl键，上下滚动滚轮对图标大小进行调节。

$regPath = "HKCU:\Control Panel\Desktop\WindowMetrics"
$iconSpacing = -1125
$iconVerticalSpacing = -1125
Set-ItemProperty -Path $regPath -Name "IconSpacing" -Value $iconSpacing -Type String
Set-ItemProperty -Path $regPath -Name "IconVerticalSpacing" -Value $iconVerticalSpacing -Type String
Write-Host "图标间距已恢复默认值"