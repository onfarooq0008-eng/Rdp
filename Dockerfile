FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y --no-install-recommends \
    firefox-esr \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    tini \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["/start.sh"]
