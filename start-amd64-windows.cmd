cls.
@echo off
color 0a
rem %1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

set PWD=%~dp0sources\
CD /D "%PWD%"
@echo "��ʼ��С�ϵܣ�"
@echo "��ǰĿ¼%PWD%"

@echo ˵��
@echo һ���˽ű�ִ��ʱ��ر�edge��chrome�����
@echo ����֧��Chrome��edge�������������Ҫ��װChrome��edge�����֮һ���������Ȥ�����Լ�DIY����������Ҳ����ħ�Ľű����á�
@echo ����ʹ��ʱ�뽫����ǽ�رգ�������ר������͹�������
@echo �ġ�Ҳ���Խ��ȸ����������ŵ� sources\Google\Chrome\Application\ ·���У�������ʹû�а�װ chrome Ҳ����ֱ��ʹ��
@echo �塢û�йȸ������Ҳ���Խ�edge���������ŵ� sources\Microsoft\Edge\Application\ ·���У�������ʹû�а�װ Edge Ҳ����ֱ��ʹ�ã���������
@echo �����ű�ʹ�õĴ��������ļ�Ϊ���ƽ��� :7900 ��http/https :7897 ��socks :7898 ��mixed :7899��������Զ����޸��˽ű������ļ��������Լ��������ļ�Ϊ׼��
@echo �ߡ��ű���windows11ϵͳx86_64�ܹ��ϲ���û������
@echo '**********************************************************'

:Choice
set /p choice=  "���� 0 ͨ�����������ļ�ʹ�ã����� 1 ���ִ�������ļ�:"
if /i "%choice%"=="0" goto ip0
if /i "%choice%"=="1" goto ip1
echo.&echo.û�����ѡ��밴�س�����ո�����ԣ�&pause >NUL 2>NUL
Goto :Choice

rem wget --connect-timeout=5 --no-check-certificate 
:ip0
curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://fastly.jsdelivr.net/gh/smallflowercat1995/docker-amd64-custom-ubuntu-topfreeproxies@master/topfreeproxies/singbox-config.json" -o ".config\config.json"
echo.&echo.�Ѿ�0���밴�س�����ո����������&pause >NUL 2>NUL
goto startproxy

:ip1
set pmin=0
set pmax=1
set /a pmod=%pmax%-%pmin%
set /a pnum=%RANDOM% %% %pmod%+%pmin%
echo %PWD%config%pnum%.json
copy /Y %PWD%config%pnum%.json "%PWD%.config\config.json"
echo.&echo.�Ѿ����ʹ���ļ�%pnum%���밴�س�����ո����������&pause >NUL 2>NUL
goto startproxy

:startproxy
@echo "�ȴ�������������Ժ�..."
@echo "������Ҫ����ԱȨ�����ɵ����ߡ�edge��chrome(chromium)�����"
taskkill /f /t /im "sing-box-windows*"  >NUL 2>NUL
taskkill /f /t /im "chrome*"  >NUL 2>NUL
taskkill /f /t /im "msedge*"  >NUL 2>NUL

@echo ��������
start "" "%PWD%sing-box-windows-amd64.exe"  -D "%PWD%.config" -c "%PWD%.config\config.json" run >nul 2>&1

rem "..\..\..\chrome-user-data"

echo �ȴ�������������Ժ�...
IF EXIST "%PWD%Google\Chrome\Application\chrome.exe" (
	echo Chrome������� "%PWD%Google\Chrome\Application\" ��
	start Google\Chrome\Application\chrome.exe --user-data-dir="%PWD%chrome-user-data" --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=��ѽڵ�&sp=EgQIAhAB"
) ELSE (
	echo Chrome��������� "%PWD%Google\Chrome\Application\" ��,���� "%PWD%Google\Chrome\Application\" ���Ƿ���� chrome.exe
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" >nul 2>&1
	IF  not errorlevel 1 (
		echo Chrome������� "C:\Program Files\Google\Chrome\Application\" ��
    		start chrome.exe --user-data-dir="%PWD%chrome-user-data"  --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=��ѽڵ�&sp=EgQIAhAB"
	) else (
		echo Chrome����������ڻ�û����ȷ��װ,"C:\Program Files\Google\Chrome\Application\chrome.exe",�볢�����°�װChrome�����
		IF EXIST "%PWD%Microsoft\Edge\Application\msedge.exe" (
			echo Edge������� "%PWD%Microsoft\Edge\Application\" ��
			start Microsoft\Edge\Application\msedge.exe --user-data-dir="%PWD%edge-user-data" --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=��ѽڵ�&sp=EgQIAhAB"
		) ELSE ( 
			echo Edge��������� "%PWD%Microsoft\Edge\Application\" ��,���� "%PWD%Microsoft\Edge\Application\" ���Ƿ���� msedge.exe
			%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" >nul 2>&1
			IF  not errorlevel 1 (
				echo Edge������� "C:\Program Files (x86)\Microsoft\Edge" ��
				start msedge.exe --user-data-dir="%PWD%edge-user-data" --proxy-server="http://127.0.0.1:7897" "https://www.youtube.com/results?search_query=��ѽڵ�&sp=EgQIAhAB"
			) ELSE (
				echo Edge����������ڻ�û����ȷ��װ,"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",�볢�����°�װEdge�����
			)
		)
	)
)

rem echo.&echo.�Ѿ�ִ�У��밴�س�����ո���رմ˴��ڣ�&pause >NUL 2>NUL