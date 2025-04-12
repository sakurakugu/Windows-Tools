import os
import sys
import time
import shutil
import urllib.request
import msvcrt
from tqdm import tqdm

def main():
    # 运行系统要为Windows
    if sys.platform != "win32":
        print("该脚本仅适用于 Windows 系统。")
        sys.exit(1)
        
    # 是否安装了 polib 库
    try:
        import polib
    except ImportError:
        print(f"\033未安装 polib 库，请输入 \"pip install polib\" 命令以安装\033[0m")
        sys.exit(1)
    
    # 获取 git 安装路径
    git_路径 = shutil.which("git")
    if not git_路径:
        print("未找到 Git 安装路径，请确保 Git 已安装并在系统路径中。")
        sys.exit(1)
    
    # 切换到临时目录并创建翻译文件夹
    临时目录 = os.environ.get("TEMP", os.getcwd())
    临时目录 = os.path.join(临时目录, "git中文翻译")
    os.makedirs(临时目录, exist_ok=True)
    os.chdir(临时目录)
    
    # 下载 Git 中文翻译文件
    po_地址 = "https://raw.githubusercontent.com/git/git/master/po/zh_CN.po"
    po_文件 = "zh_CN.po"
    try:
        print("正在下载中文翻译文件……")
        with tqdm(unit='B', unit_scale=True, desc=po_文件, miniters=1) as t:
            def reporthook(b=1, bsize=1, tsize=None):
                if tsize is not None:
                    t.total = tsize
                # 使用 reporthook.last_b 存储前一次的块数
                t.update((b - reporthook.last_b) * bsize)
                reporthook.last_b = b
            reporthook.last_b = 0
            urllib.request.urlretrieve(po_地址, po_文件, reporthook=reporthook)
    except Exception as e:
        print(f"\033[31m下载失败: {e}\033[0m")
        sys.exit(1)
        
    # 将 zh_CN.po 文件转换为 git.mo 文件
    mo_文件 = "git.mo"
    try:
        print("正在转换翻译文件……")
        # 使用 polib 库进行转换
        po_文件 = polib.pofile(po_文件)
        po_文件.save_as_mofile(mo_文件)
    except Exception as e:
        print(f"\033[31m转换失败: {e}\033[0m")
        sys.exit(1)
    
    # 根据 git 的安装路径定位目标目录并创建
    git_路径 = os.path.dirname(git_路径)
    目标目录 = os.path.abspath(os.path.join(git_路径, "..", "mingw64", "share", "locale", "zh_CN", "LC_MESSAGES"))
    os.makedirs(目标目录, exist_ok=True)
    
    # 复制 git.mo 到目标目录
    目标路径 = os.path.join(目标目录, "git.mo")
    try:
        shutil.copyfile(os.path.join(临时目录, mo_文件), 目标路径)
        print("已将 Git 的界面翻译为中文，重启终端即可生效。")
    except Exception as e:
        print(f"\033[31m复制文件失败: {e}\033[0m")
        sys.exit(1)
    
    # 10秒倒计时或任意键退出
    print("\n请按任意键继续...", end="", flush=True)
    退出时间 = 10
    开始时间 = time.time()
    while True:
        if msvcrt.kbhit():
            msvcrt.getch()  # 获取按下的键
            break
        if time.time() - 开始时间 > 退出时间:
            break
        time.sleep(0.1)

if __name__ == "__main__":
    main()