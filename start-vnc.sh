#!/bin/bash

set -e

echo "================================="
echo " Starting Ubuntu XFCE Desktop "
echo "================================="


# 创建 VNC 配置目录
mkdir -p /root/.vnc


# 设置 VNC 密码权限
chmod 600 /root/.vnc/passwd


# 如果已经存在旧的 VNC 会话，先关闭
vncserver -kill :1 >/dev/null 2>&1 || true


echo "Starting VNC server..."


# 启动 XFCE 桌面
vncserver :1 \
    -geometry 1280x800 \
    -localhost no


echo "Generating SSL certificate..."


# 生成 noVNC 使用的 HTTPS 证书
openssl req \
    -new \
    -x509 \
    -days 365 \
    -nodes \
    -subj "/C=CN/ST=Docker/L=Desktop/O=Ubuntu" \
    -out /root/self.pem \
    -keyout /root/self.pem


echo "Starting noVNC web service..."


# 启动浏览器访问服务
websockify \
    --web=/usr/share/novnc/ \
    --cert=/root/self.pem \
    6080 \
    localhost:5901 &


echo "================================="
echo " Desktop is ready!"
echo " Access:"
echo " https://YOUR-IP:6080"
echo "================================="


# 保持 Docker 容器运行
tail -f /dev/null
