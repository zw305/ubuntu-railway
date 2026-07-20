FROM --platform=linux/amd64 ubuntu:22.04


# 防止安装软件时交互询问
ENV DEBIAN_FRONTEND=noninteractive

# 设置时区
ENV TZ=Asia/Shanghai


# 安装桌面、VNC、浏览器、工具
RUN apt update && apt install -y \
    xfce4 \
    xfce4-goodies \
    tigervnc-standalone-server \
    novnc \
    websockify \
    dbus-x11 \
    x11-utils \
    x11-xserver-utils \
    x11-apps \
    sudo \
    xterm \
    vim \
    net-tools \
    curl \
    wget \
    git \
    tzdata \
    software-properties-common \
    openssl \
    && rm -rf /var/lib/apt/lists/*


# 添加 Firefox 官方源
RUN add-apt-repository ppa:mozillateam/ppa -y \
    && echo 'Package: *' > /etc/apt/preferences.d/mozilla-firefox \
    && echo 'Pin: release o=LP-PPA-mozillateam' >> /etc/apt/preferences.d/mozilla-firefox \
    && echo 'Pin-Priority: 1001' >> /etc/apt/preferences.d/mozilla-firefox


# 安装 Firefox
RUN apt update \
    && apt install -y firefox xubuntu-icon-theme \
    && rm -rf /var/lib/apt/lists/*


# 创建X认证文件
RUN touch /root/.Xauthority


# 创建VNC密码
RUN mkdir -p /root/.vnc \
    && echo "docker123" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd


# 复制启动脚本
# COPY start.sh /start.sh

# RUN chmod +x /start.sh
COPY start-vnc.sh /start-vnc.sh

RUN chmod +x /start-vnc.sh

CMD ["/start-vnc.sh"]


# VNC端口
EXPOSE 5901

# noVNC网页端口
EXPOSE 6080


CMD ["/start.sh"]
