FROM debian:latest

# Installiere Abhängigkeiten
RUN apt-get update && apt-get install -y \
    git \
    inotify-tools \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Kopiere das Sync-Skript
COPY obsidian_sync.sh /app/obsidian_sync.sh

# Mach das Skript ausführbar
RUN chmod +x /app/obsidian_sync.sh

CMD ["/app/obsidian_sync.sh"]
