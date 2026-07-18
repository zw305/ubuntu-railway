FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=password123
ENV DISPLAY=:1
ENV VNC_PORT=5900

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-terminal \
    tigervnc-standalone-server \
    tigervnc-common \
    novnc \
    websockify \
    wget \
    curl \
    nano \
    htop \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash vncuser

WORKDIR /home/vncuser

RUN mkdir -p /home/vncuser/.vnc && \
    echo "${VNC_PASSWORD}" | vncpasswd -f > /home/vncuser/.vnc/passwd && \
    chmod 600 /home/vncuser/.vnc/passwd && \
    chown -R vncuser:vncuser /home/vncuser

COPY start-vnc.sh /home/vncuser/start-vnc.sh
RUN chmod +x /home/vncuser/start-vnc.sh && \
    chown vncuser:vncuser /home/vncuser/start-vnc.sh

USER vncuser

EXPOSE 5900 6080

CMD ["/home/vncuser/start-vnc.sh"]
