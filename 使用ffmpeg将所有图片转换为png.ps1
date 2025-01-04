# 使用ffmpeg将所有图片转换为png.ps1

# 获取当前工作目录
$workdir = Get-Location

# 定义要转换的图片类型
$imageTypes = @("*.jpg", "*.jpeg", "*.bmp", "*.tiff")

# 遍历所有图片文件
foreach ($type in $imageTypes) {
    $files = Get-ChildItem -Path $workdir -Filter $type
    foreach ($file in $files) {
        $inputFile = $file.FullName
        $outputname = $file.BaseName + ".png"
        # 转换为png
        ffmpeg -i $inputFile $outputname
    }
}

Write-Host "转换完成" -ForegroundColor Green