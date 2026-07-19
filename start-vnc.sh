#!/bin/bash

# 禁用 xfce4 的锁屏和休眠配置
su vncuser -c "mkdir -p /home/vncuser/.config/xfce4/xfconf/xfce-perchannel-xml"
su vncuser -c "echo '<?xml version=\"1.0\" encoding=\"UTF-8\"?><channel name=\"xfce4-power-manager\" version=\"1.0\"><property name=\"xfce4-power-manager\" type=\"empty\"><property name=\"lock-screen-suspend-hibernate\" type=\"bool\" value=\"false\"/></property></channel>' > /home/vncuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml"

# 1. 启动 VNC 服务器
su vncuser -c "vncserver -geometry 1280x720 -depth 24 -localhost no :1"

# 2. 启动 noVNC 
websockify --web=/usr/share/novnc 6080 localhost:5901
