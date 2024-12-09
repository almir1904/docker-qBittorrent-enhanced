FROM ghcr.io/linuxserver/baseimage-alpine:3.21 as builder
LABEL maintainer="Almir1904"

WORKDIR /qbittorrent

COPY install.sh ReleaseTag /qbittorrent/
RUN  apk add --no-cache ca-certificates curl && \
     chmod a+x install.sh && \
     bash install.sh

# Stage 2: Create the final image
FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# Environment settings
ENV TZ=Europe/Vienna
ENV WEBUIPORT=8046

# Add local files and install qBittorrent
COPY root /
COPY --from=builder /qbittorrent/qbittorrent-nox /usr/local/bin/qbittorrent-nox

# Install python3 and clean up
RUN apk add --no-cache python3 && \
    chmod a+x /usr/local/bin/qbittorrent-nox

# Ports and volumes
VOLUME /downloads /config
EXPOSE 8046 6881 6881/udp

# Healthcheck
HEALTHCHECK CMD curl -s http://localhost:${WEBUIPORT}/ || exit 1

# Default command
CMD ["/usr/local/bin/qbittorrent-nox"]
