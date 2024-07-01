#!/usr/bin/env bash

# 当前路径
PWD=`pwd`/sources
cd ${PWD}

# github 项目 SagerNet/sing-box
URI="SagerNet/sing-box"
# 从 SagerNet/sing-box 官网中提取全部 tag 版本，获取最新版本赋值给 VERSION 后打印
VERSION=$(curl -sL "https://github.com/$URI/releases" | grep -oP '(?<=\/releases\/tag\/)[^"]+' | head -n 1)
echo $VERSION

# 拼接下载链接 URI_DOWNLOAD 后打印 
URI_DOWNLOAD="https://github.com/$URI/releases/download/$VERSION/"
echo $URI_DOWNLOAD

# unar 解压函数
extract_single_file() {
  # 第一个参数压缩包名
  local ARCHIVE=$1
  # 处理第二个参数提取路径
  local DIRNAME=${2%/*} ; echo ${DIRNAME}
  # 处理第二个参数提取文件名
  local FILE=${2##*/} ; echo ${FILE}
  # 第3个参数文件重命名
  local NEW_FILENAME=$3
  # 第4个参数创建临时目录
  local OUTPUT_DIR=$(mktemp -d)
  # 解压压缩包文件至临时目录
  unar -o "${OUTPUT_DIR}" "${ARCHIVE}" || return $?
  # 移动文件并重命名
  mv -fv "${OUTPUT_DIR}/${DIRNAME}/${FILE}" ./${NEW_FILENAME} ; chmod -v u+x ./${NEW_FILENAME} 
  # 删除临时目录和压缩包
  rm -rfv "${OUTPUT_DIR}" "${ARCHIVE}"
}


# 更新url节点
update_url(){
    curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://raw.githubusercontent.com/smallflowercat1995/docker-amd64-custom-ubuntu-topfreeproxies/master/topfreeproxies/singbox-config.json" -o "config0.json" -O
}

# 更新程序 windows amd64
update_windows_amd64(){
# 打印下载链接
echo "${URI_DOWNLOAD}sing-box-${VERSION#v}-windows-amd64.zip"

# 下载
wget -t 3 -T 5 --verbose --show-progress=on --progress=bar --no-check-certificate --hsts-file=/tmp/wget-hsts -c "${URI_DOWNLOAD}sing-box-${VERSION#v}-windows-amd64.zip" -O"sing-box-${VERSION#v}-windows-amd64.zip"

# 覆盖解压
ARCHIVE="sing-box-${VERSION#v}-windows-amd64.zip"
FILE="sing-box-${VERSION#v}-windows-amd64/sing-box.exe"
NEW_FILENAME="sing-box-windows-amd64.exe"
extract_single_file "${ARCHIVE}" "${FILE}" "${NEW_FILENAME}"
}

# 更新程序 darwin amd64
update_darwin_amd64(){
# 打印下载链接
echo "${URI_DOWNLOAD}sing-box-${VERSION#v}-darwin-amd64.tar.gz"

# 下载
wget -t 3 -T 5 --verbose --show-progress=on --progress=bar --no-check-certificate --hsts-file=/tmp/wget-hsts -c "${URI_DOWNLOAD}sing-box-${VERSION#v}-darwin-amd64.tar.gz" -O"sing-box-${VERSION#v}-darwin-amd64.tar.gz"

# 覆盖解压
ARCHIVE="sing-box-${VERSION#v}-darwin-amd64.tar.gz"
FILE="sing-box-${VERSION#v}-darwin-amd64/sing-box"
NEW_FILENAME="sing-box-darwin-amd64"
extract_single_file "${ARCHIVE}" "${FILE}" "${NEW_FILENAME}"
}

# 更新程序 linux amd64
update_linux_amd64(){
# 打印下载链接
echo "${URI_DOWNLOAD}sing-box-${VERSION#v}-linux-amd64.tar.gz"

# 下载
wget -t 3 -T 5 --verbose --show-progress=on --progress=bar --no-check-certificate --hsts-file=/tmp/wget-hsts -c "${URI_DOWNLOAD}sing-box-${VERSION#v}-linux-amd64.tar.gz" -O"sing-box-${VERSION#v}-linux-amd64.tar.gz"

# 覆盖解压
ARCHIVE="sing-box-${VERSION#v}-linux-amd64.tar.gz"
FILE="sing-box-${VERSION#v}-linux-amd64/sing-box"
NEW_FILENAME="sing-box-linux-amd64"
extract_single_file "${ARCHIVE}" "${FILE}" "${NEW_FILENAME}"
}

# 更新程序 linux arm64
update_linux_arm64(){
# 打印下载链接
echo "${URI_DOWNLOAD}sing-box-${VERSION#v}-linux-arm64.tar.gz"

# 下载
wget -t 3 -T 5 --verbose --show-progress=on --progress=bar --no-check-certificate --hsts-file=/tmp/wget-hsts -c "${URI_DOWNLOAD}sing-box-${VERSION#v}-linux-arm64.tar.gz" -O"sing-box-${VERSION#v}-linux-arm64.tar.gz"

# 覆盖解压
ARCHIVE="sing-box-${VERSION#v}-linux-arm64.tar.gz"
FILE="sing-box-${VERSION#v}-linux-arm64/sing-box"
NEW_FILENAME="sing-box-linux-arm64"
extract_single_file "${ARCHIVE}" "${FILE}" "${NEW_FILENAME}"
}

# 执行操作
update_url
update_windows_amd64
update_darwin_amd64
update_linux_amd64
update_linux_arm64

# 返回上层目录
cd ../ ; echo "ok good!"
chmod -vR 777 ./

# 解除环境
unset PWD_HOME DOWNLOAD
echo ${PWD} ${DOWNLOAD}
