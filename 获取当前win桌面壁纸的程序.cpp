/**
 * 获取当前win桌面壁纸的命令行程序
 */
#include <filesystem>
#include <iostream>
#include <windows.h>

int main() {
    char path[MAX_PATH];
    // 获取当前win桌面壁纸的地址
    SystemParametersInfo(SPI_GETDESKWALLPAPER, MAX_PATH, path, 0);

    std::cout << "当前桌面壁纸路径: " << path << std::endl;
    
    // 获取用户下载文件夹路径
    char* userProfile = getenv("USERPROFILE");
    if (userProfile == nullptr) {
        std::cerr << "无法获取用户配置文件路径" << std::endl;
        return 1;
    }
    std::string downloadPath = std::string(userProfile) + "\\Downloads\\wallpaper.jpg";

    // 将壁纸复制到下载文件夹
    try {
        std::filesystem::copy(path, downloadPath, std::filesystem::copy_options::overwrite_existing);
        std::cout << "壁纸已复制到: " << downloadPath << std::endl;
    } catch (const std::filesystem::filesystem_error& e) {
        std::cerr << "文件系统错误: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}