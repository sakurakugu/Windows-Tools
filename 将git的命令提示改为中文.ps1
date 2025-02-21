$gitPath = (Get-Command git).Source
if ($gitPath) {
    # 下载 Git 中文翻译文件
    cd $env:USERPROFILE
    mkdir "git中文翻译" -Force
    cd ".\git中文翻译"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/git/git/master/po/zh_CN.po" -OutFile "zh_CN.po"

# todo：https://github.com/mlocati/gettext-iconv-windows/
    # 如果没用安装msgfmt，需要安装gettext
    # if (!(Get-Command msgfmt -ErrorAction SilentlyContinue)) {
    #     echo "尚未安装`“翻译文件格式转换工具GetText`”，正在安装......"
    #     winget install --id mlocati.GetText --source winget
    # }

    # 将zh_CN.po文件转换为git.mo文件
    msgfmt -o ".\git.mo" ".\zh_CN.po"

    # 放置中文翻译文件
    $gitDir = Split-Path -Parent $gitPath
    mkdir "$gitDir\..\mingw64\share\locale\zh_CN\LC_MESSAGES"  -Force
    cp "$env:USERPROFILE\git中文翻译\git.mo" "$gitDir\..\mingw64\share\locale\zh_CN\LC_MESSAGES\git.mo" -Force

    # 删除中间文件
    echo "正在删除中间文件......"
    # Remove-Item -Path "$env:USERPROFILE\git中文翻译" -Recurse -Force
    $input = Read-Host("是否卸载 `“翻译文件格式转换工具GetText`” （是=Y/否=N）")
    if ($input -eq "Y" -or $input -eq "y") {
        # winget uninstall --id mlocati.GetText
    }
    
    echo "已将 Git 的界面翻译为中文，重启终端即可生效。"

}
else {
    Write-Host "未找到 Git 安装路径，请确保 Git 已安装并在系统路径中。"
}



    

