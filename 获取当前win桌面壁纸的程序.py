import ctypes
import os
import shutil

def main():
    MAX_PATH = 260
    wallpaper = ctypes.create_unicode_buffer(MAX_PATH)
    SPI_GETDESKWALLPAPER = 0x0073
    # 获取当前桌面壁纸路径
    if ctypes.windll.user32.SystemParametersInfoW(SPI_GETDESKWALLPAPER, MAX_PATH, wallpaper, 0) == 0:
        print(f"\033[31m无法获取当前桌面壁纸的路径\033[0m")
        return 1

    壁纸路径 = wallpaper.value
    print("当前桌面壁纸路径:", 壁纸路径)

    用户目录 = os.getenv("USERPROFILE")
    if not 用户目录:
        print(f"\033[31m无法获取用户配置文件路径\033[0m")
        return 1

    下载路径 = os.path.join(用户目录, "Downloads", "wallpaper.jpg")

    try:
        shutil.copy(壁纸路径, 下载路径)
        print("壁纸已复制到:", 下载路径)
    except Exception as e:
        print(f"\033[31m文件复制错误: {e}\033[0m")
        return 1

    return 0

if __name__ == "__main__":
    main()