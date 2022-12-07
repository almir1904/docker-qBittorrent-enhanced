FROM ghcr.io/linuxserver/baseimage-alpine:3.17 as builder
LABEL maintainer="Almir1904"

WORKDIR /qbittorrent

COPY install.sh /qbittorrent/
COPY ReleaseTag /qbittorrent/

RUN  apk add --no-cache ca-certificates curl

RUN cd /qbittorrent \
        && chmod a+x install.sh \
        && bash install.sh

# docker qBittorrent-Enhanced-Edition

FROM ghcr.io/linuxserver/baseimage-alpine:3.17

# environment settings
ENV TZ=Europe/Vienna
ENV WEBUIPORT=8046

# add local files and install qbitorrent
COPY root /
COPY --from=builder  /qbittorrent/qbittorrent-nox   /usr/local/bin/qbittorrent-nox

# install python3
RUN  apk add --no-cache python3 \
&&   rm -rf /var/cache/apk/*   \
&&   chmod a+x  /usr/local/bin/qbittorrent-nox

# ports and volumes
VOLUME /downloads /config
EXPOSE 8046  6881  6881/udp
