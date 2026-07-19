#!/bin/bash

# 1. 启动 VNC 服务器（关闭自带的锁屏以防卡死）
su vncuser -c "vncserver -geometry 1280x720 -depth 24 -localhost no :1"

# 2. 启动 noVNC 
websockify --web=/usr/share/novnc 6080 localhost:5900
