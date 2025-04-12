@REM 解决方案
@REM 前提：图标缓存文件是隐藏文件，我们需要在资源管理器中将设置改为“显示所有文件”，显示隐藏的项目。
@REM 1. 按下快捷键 Win+R，在打开的运行窗口中输入 %localappdata%，回车。
@REM 2. 在打开的文件夹中，找到 Iconcache.db，将其删除。
@REM 3. 在任务栏上右击鼠标，在弹出的菜单中点击“任务管理器”。
@REM 4. 在任务管理器中找到“Windows资源管理器”，右击鼠标，选择“重新启动”即可重建图标缓存。

taskkill /f /im explorer.exe
cd /d %userprofile%\AppData\Local
del IconCache.db /a
start explorer.exe