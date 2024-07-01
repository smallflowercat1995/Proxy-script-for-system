#!/usr/bin/env bash
PWD=`pwd`/sources
cd ${PWD}
curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://fastly.jsdelivr.net/gh/smallflowercat1995/docker-amd64-custom-ubuntu-topfreeproxies@master/topfreeproxies/singbox-config.json" -o "config0.json" -O
