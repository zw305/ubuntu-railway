#!/bin/bash

# 启动 VNC 服务器
vncserver -geometry 1280x720 -depth 24 -localhost no :1

# 启动 noVNC
websockify --web=/usr/share/novnc 6080 localhost:5900 &

# 保持容器运行
tail -f /dev/null
