cls.
@echo off
color 0a
rem %1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

set PWD=%~dp0sources\
CD /D "%PWD%"
@echo "开始吧小老弟！"
@echo "当前目录%PWD%"

@echo 说明
@echo 一、此脚本执行时会关闭edge和chrome浏览器
@echo 二、支持Chrome和edge浏览器，所以需要安装Chrome或edge浏览器之一，如果有兴趣可以自己DIY别的浏览器，也可以魔改脚本自用。
@echo 三、使用时请将防火墙关闭，并允许专用网络和公用网络
@echo 四、也可以将谷歌浏览器程序放到 sources\Google\Chrome\Application\ 路径中，这样即使没有安装 chrome 也可以直接使用
@echo 五、没有谷歌浏览器也可以将edge浏览器程序放到 sources\Microsoft\Edge\Application\ 路径中，这样即使没有安装 Edge 也可以直接使用，自行意会吧
@echo 六、脚本使用的代理配置文件为控制界面 :7900 ，http/https :7897 ，socks :7898 ，mixed :7899，如果你自定义修改了脚本配置文件，请以自己的配置文件为准。
@echo 七、脚本在windows11系统x86_64架构上测试没有问题
@echo '**********************************************************'

:Choice
set /p choice=  "输入 0 通过联网更新文件使用，输入 1 随机执行现有文件:"
if /i "%choice%"=="0" goto ip0
if /i "%choice%"=="1" goto ip1
echo.&echo.没有这个选项，请按回车键或空格键重试！&pause >NUL 2>NUL
Goto :Choice

rem wget --connect-timeout=5 --no-check-certificate 
:ip0
curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://fastly.jsdelivr.net/gh/smallflowercat1995/docker-amd64-custom-ubuntu-topfreeproxies@master/topfreeproxies/singbox-config.json" -o ".config\config.json"
echo.&echo.已经0，请按回车键或空格键启动程序！&pause >NUL 2>NUL
goto startproxy

:ip1
set pmin=0
set pmax=1
set /a pmod=%pmax%-%pmin%
set /a pnum=%RANDOM% %% %pmod%+%pmin%
echo %PWD%config%pnum%.json
copy /Y %PWD%config%pnum%.json "%PWD%.config\config.json"
echo.&echo.已经随机使用文件%pnum%，请按回车键或空格键启动程序！&pause >NUL 2>NUL
goto startproxy

:startproxy
@echo "等待软件启动，请稍候..."
@echo "可能需要管理员权限来干掉工具、edge和chrome(chromium)浏览器"
taskkill /f /t /im "sing-box-windows*"  >NUL 2>NUL
taskkill /f /t /im "chrome*"  >NUL 2>NUL
taskkill /f /t /im "msedge*"  >NUL 2>NUL

@echo 启动工具
start "" "%PWD%sing-box-windows-amd64.exe"  -D "%PWD%.config" -c "%PWD%.config\config.json" run >nul 2>&1

rem "..\..\..\chrome-user-data"

echo 等待软件启动，请稍候...
IF EXIST "%PWD%Google\Chrome\Application\chrome.exe" (
	echo Chrome浏览器在 "%PWD%Google\Chrome\Application\" 中
	start Google\Chrome\Application\chrome.exe --user-data-dir="%PWD%chrome-user-data" --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
) ELSE (
	echo Chrome浏览器不在 "%PWD%Google\Chrome\Application\" 中,请检查 "%PWD%Google\Chrome\Application\" 中是否存在 chrome.exe
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" >nul 2>&1
	IF  not errorlevel 1 (
		echo Chrome浏览器在 "C:\Program Files\Google\Chrome\Application\" 中
    		start chrome.exe --user-data-dir="%PWD%chrome-user-data"  --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
	) else (
		echo Chrome浏览器不存在或没有正确安装,"C:\Program Files\Google\Chrome\Application\chrome.exe",请尝试重新安装Chrome浏览器
		IF EXIST "%PWD%Microsoft\Edge\Application\msedge.exe" (
			echo Edge浏览器在 "%PWD%Microsoft\Edge\Application\" 中
			start Microsoft\Edge\Application\msedge.exe --user-data-dir="%PWD%edge-user-data" --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
		) ELSE ( 
			echo Edge浏览器不在 "%PWD%Microsoft\Edge\Application\" 中,请检查 "%PWD%Microsoft\Edge\Application\" 中是否存在 msedge.exe
			%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" >nul 2>&1
			IF  not errorlevel 1 (
				echo Edge浏览器在 "C:\Program Files (x86)\Microsoft\Edge" 中
				start msedge.exe --user-data-dir="%PWD%edge-user-data" --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB"
			) ELSE (
				echo Edge浏览器不存在或没有正确安装,"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",请尝试重新安装Edge浏览器
			)
		)
	)
)

rem echo.&echo.已经执行，请按回车键或空格键关闭此窗口！&pause >NUL 2>NUL