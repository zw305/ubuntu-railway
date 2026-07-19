FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=password123
ENV DISPLAY=:1

# 安装桌面、VNC、noVNC，并顺便卸载可能导致锁屏的组件
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-terminal \
    tigervnc-server \
    tigervnc-common \
    novnc \
    websockify \
    wget \
    curl \
    && apt-get remove -y light-locker xfce4-screensaver \
    && rm -rf /var/lib/apt/lists/*

# 创建运行用户并设置系统密码（让系统密码也等于 password123）
RUN useradd -m -s /bin/bash vncuser && \
    echo "vncuser:password123" | chpasswd

WORKDIR /home/vncuser

# 配置 VNC 密码
RUN mkdir -p /home/vncuser/.vnc && \
    echo "${VNC_PASSWORD}" | vncpasswd -f > /home/vncuser/.vnc/passwd && \
    chmod 600 /home/vncuser/.vnc/passwd && \
    chown -R vncuser:vncuser /home/vncuser

COPY start-vnc.sh /home/vncuser/start-vnc.sh
RUN chmod +x /home/vncuser/start-vnc.sh

# 暴露 noVNC 的默认端口
EXPOSE 6080

CMD ["/home/vncuser/start-vnc.sh"]
