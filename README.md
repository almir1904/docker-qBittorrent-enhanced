# docker-qBittorrent-enhanced-edition


docker run -d \
  --name=qbittorrent \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Vienna \
  -e WEBUI_PORT=8046 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -p 8046:8046 \
  -v /pathtochange:/config \
  -v /pathtochange:/downloads \
  --restart unless-stopped \
  almir1904/docker-qbittorrent-enhanced
