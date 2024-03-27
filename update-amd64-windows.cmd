cls.
@echo off
color 0a
rem %1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
set PWD=%~dp0sources\

CD /D "%PWD%"

@echo "当前目录%PWD%"

curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://fastly.jsdelivr.net/gh/smallflowercat1995/docker-amd64-custom-ubuntu-topfreeproxies@master/debian.backup/topfreeproxies/singbox-config.json" -o "config0.json" -O

rem echo.&echo.已经完成，请按回车键或空格键关闭此窗口！&pause >NUL 2>NUL