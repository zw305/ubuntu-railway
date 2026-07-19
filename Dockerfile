FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=password123
ENV DISPLAY=:1

# 仅安装核心的桌面、VNC 和 noVNC
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-terminal \
    tigervnc-server \
    tigervnc-common \
    novnc \
    websockify \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 创建运行用户
RUN useradd -m -s /bin/bash vncuser

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
