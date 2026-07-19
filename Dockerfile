FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive     DISPLAY=:1     VNC_PORT=5901     WEB_PORT=8080     USER=app     HOME=/home/app

RUN apt-get update && apt-get install -y --no-install-recommends     ca-certificates     curl     wget     xz-utils     bash     supervisor     openbox     xterm     dbus-x11     x11vnc     xvfb     websockify     python3     python3-numpy     fonts-dejavu-core     net-tools     procps     && rm -rf /var/lib/apt/lists/*

# noVNC (web UI)
RUN mkdir -p /opt/novnc /opt/novnc/utils/websockify && \
    wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.5.0.tar.gz \
    | tar xz --strip-components=1 -C /opt/novnc && \
    wget -qO- https://github.com/novnc/websockify/archive/refs/tags/v0.12.0.tar.gz \
    | tar xz --strip-components=1 -C /opt/novnc/utils/websockify

# lightweight apps
RUN apt-get update && apt-get install -y --no-install-recommends     pcmanfm     firefox-esr     && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash app &&     mkdir -p /home/app/.config/openbox /home/app/.vnc /home/app/Desktop &&     chown -R app:app /home/app

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY index.html /opt/novnc/index.html

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-n"]
