#!/usr/bin/env bash
clear

PWD=`pwd`/sources
cd ${PWD}

echo "开始吧小老弟！"
echo "当前目录${PWD}"

startclash(){
echo "等待软件启动，请稍候..."
echo "可能需要输入密码来干掉工具、edge和chrome(chromium)浏览器"
sudo kill -9 `ps -ef | grep -v grep | grep sing-box-linux-amd64 | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep sing-box-linux-amd64 | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep msedge | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep microsoft-edge | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep microsoft-edge-dev | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep google-chrome | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep google-chrome-stable | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep chromium | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep chromium-browser | awk '{print $2}'`
kill -9 `ps -ef | grep -v grep | grep tail | awk '{print $2}'`
rm -rfv "*.log" chrome-user-data/SingletonLock edge-user-data/SingletonLock

chmod u+x sing-box-linux-amd64
nohup sudo ${PWD}/sing-box-linux-amd64 -D ${PWD}/.config -c ${PWD}/.config/config.json run > sing-box-linux-amd64.log 2>&1 & disown

# 判断浏览器进程位置是否存在
if [ -e /usr/bin/microsoft-edge ];then
echo "microsoft-edge-dev true"
# microsoft-edge
nohup /usr/bin/microsoft-edge --no-sandbox --disable-gpu --disable-software-rasterizer --user-data-dir="${PWD}/edge-user-data" --proxy-server=http://127.0.0.1:7897 "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB" > edge.log 2>&1 & disown
elif [ -e /usr/bin/microsoft-edge-dev ];then
echo "microsoft-edge-dev true"
# microsoft-edge-dev
nohup /usr/bin/microsoft-edge-dev --no-sandbox --disable-gpu --disable-software-rasterizer --user-data-dir="${PWD}/edge-user-data" --proxy-server=http://127.0.0.1:7897 "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB" > edge.log 2>&1 & disown
elif [ -e /usr/bin/google-chrome ];then
echo "google-chrome true"
# google-chrome
nohup /usr/bin/google-chrome --no-sandbox --disable-gpu --disable-software-rasterizer --user-data-dir="${PWD}/chrome-user-data" --proxy-server=http://127.0.0.1:7897 "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB" > chrome.log 2>&1 & disown
elif [ -e /usr/bin/google-chrome-stable ];then
echo "google-chrome-stable true"
# google-chrome-stable
nohup /usr/bin/google-chrome-stable --no-sandbox --disable-gpu --disable-software-rasterizer --user-data-dir="${PWD}/chrome-user-data" --proxy-server=http://127.0.0.1:7897 "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB" > chrome.log 2>&1 & disown
elif [ -e /usr/bin/chromium ];then
echo "true"
nohup /usr/bin/chromium --no-sandbox --disable-gpu --disable-software-rasterizer --user-data-dir="${PWD}/chrome-user-data" --proxy-server=http://127.0.0.1:7897 "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB" > chromium.log 2>&1 & disown
elif [ -e /usr/lib64/chromium-browser/chromium-browser ];then
echo "true"
nohup /usr/lib64/chromium-browser/chromium-browser --no-sandbox --disable-gpu --disable-software-rasterizer --user-data-dir="${PWD}/chrome-user-data" --proxy-server=http://127.0.0.1:7897 "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAhAB" > chromium.log 2>&1 & disown
elif [ -e /usr/lib/chromium-browser/chromium-browser ];then
echo "true"
nohup /usr/lib/chromium-browser/chromium-browser --no-sandbox --disable-gpu --disable-software-rasterizer --user-data-dir="${PWD}/chrome-user-data" --proxy-server=http://127.0.0.1:7897 "https://www.youtube.com/results?search_query=免费节点&sp=EgQIAxAB" > chromium.log 2>&1 & disown
else 
echo -e "chromium/edge/google-chrome浏览器不存在或没有正确安装，请尝试重新安装chromium/google-chrome浏览器\n或者您可以通过安装snap来安装chromium/google-chrome，这样会比较好"
fi

tail -200f sing-box-linux-amd64.log
}

choices(){

echo 说明
echo 一、此脚本执行时会关闭edge和chrome浏览器
echo 二、支持Chrome和edge浏览器，所以需要安装Chrome或edge浏览器之一，如果有兴趣可以自己DIY别的浏览器，也可以魔改脚本自用。
echo 三、使用时请将防火墙关闭，并允许专用网络和公用网络
echo 四、也可以将谷歌浏览器程序放到 sources/Google/Chrome/Application/ 路径中，这样即使没有安装 chrome 也可以直接使用
echo 五、没有谷歌浏览器也可以将edge浏览器程序放到 sources/Microsoft/Edge/Application/ 路径中，这样即使没有安装 Edge 也可以直接使用，自行意会吧
echo 六、脚本使用的代理配置文件为控制界面 :7900 ，http/https :7897 ，socks :7898 ，mixed :7899 ，如果你自定义修改了脚本配置文件，请以自己的配置文件为准。
echo 七、脚本在linux debian 11系统x86_64架构上测试没有问题
echo '**********************************************************'

echo "输入 0 通过联网更新文件使用，输入 1 随机执行现有文件:"
read choice 
if [ $choice -eq 0 ];then
curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://fastly.jsdelivr.net/gh/smallflowercat1995/docker-amd64-custom-ubuntu-topfreeproxies@master/topfreeproxies/singbox-config.json" -o ".config/config.json" -O
echo 已经0启动程序！
startclash
elif [ $choice -eq 1 ];then
pool=(0)
num=${#pool[*]}
pn=${pool[$((RANDOM%num+1))]}
echo $pn
if [ "$pn" = "" ]; then
	cp -fv config0.json ".config/config.json"
else
	cp -fv config$pn.json ".config/config.json"
fi
echo 已经随机启动程序！
startclash
else
echo "what's up?"
choices
fi
}

choices
