cls.
@echo off
color 0a
rem %1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
set PWD=%~dp0sources\

CD /D "%PWD%"

@echo "��ǰĿ¼%PWD%"

curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://fastly.jsdelivr.net/gh/smallflowercat1995/docker-amd64-custom-ubuntu-topfreeproxies@master/topfreeproxies/singbox-config.json" -o "config0.json" -O

rem echo.&echo.�Ѿ���ɣ��밴�س�����ո���رմ˴��ڣ�&pause >NUL 2>NUL