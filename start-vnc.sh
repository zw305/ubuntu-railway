#!/bin/bash

echo "================================="
echo " Starting Ubuntu XFCE Desktop "
echo "================================="

# 创建 VNC 配置目录
mkdir -p /root/.vnc

# 如果 VNC 密码文件不存在，创建它
if [ ! -f /root/.vnc/passwd ]; then
    echo "Creating VNC password..."
    echo "docker123" | vncpasswd -f > /root/.vnc/passwd
fi

# 设置 VNC 密码文件权限
chmod 600 /root/.vnc/passwd
echo "VNC password file ready"

# 如果已经存在旧的 VNC 会话，先关闭
vncserver -kill :1 >/dev/null 2>&1 || true
sleep 1

echo "Starting VNC server..."

# 启动 XFCE 桌面（使用 TigerVNC）
# 注意：vncserver 不支持 & 后台运行，它本身就是守护进程
vncserver :1 \
    -geometry 1280x800 \
    -localhost no \
    -fg 2>&1 &

# 给 VNC 服务器一点时间启动
sleep 3

# 检查 VNC 服务器是否成功启动
if netstat -tuln 2>/dev/null | grep -q ":5901 "; then
    echo "✓ VNC server is listening on port 5901"
else
    echo "⚠ Warning: VNC server may not be listening yet"
    echo "Checking vncserver status..."
    ps aux | grep -i vncserver | grep -v grep || echo "No vncserver process found"
fi

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

echo "Certificate generated"

echo "Starting noVNC web service..."

# 启动浏览器访问服务
websockify \
    --web=/usr/share/novnc/ \
    --cert=/root/self.pem \
    6080 \
    localhost:5901 &

sleep 2

echo "================================="
echo " Desktop is ready!"
echo " Access:"
echo " https://YOUR-IP:6080"
echo " VNC Password: docker123"
echo "================================="

# 监控日志
echo "Monitoring services..."
ps aux | grep -E "vncserver|websockify" | grep -v grep

# 保持 Docker 容器运行
tail -f /dev/null

