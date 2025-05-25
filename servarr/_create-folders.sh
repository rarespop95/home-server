#!/bin/bash

# Set PUID and PGID — you can export these in your shell or .env
# To get PUID and PGID, run: 'id'

PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Base directories
CONFIG_DIR="/docker"

echo "📁 Creating base data directory..."
mkdir -p "$DATA_DIR" && sudo chown -R $PUID:$PGID "$DATA_DIR"

# Container-specific config directories
echo "📁 Creating config directories in $CONFIG_DIR..."

mkdir -p "${CONFIG_DIR}/prowlarr" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/prowlarr"
mkdir -p "${CONFIG_DIR}/flaresolverr" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/flaresolverr"
mkdir -p "${CONFIG_DIR}/sonarr" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/sonarr"
mkdir -p "${CONFIG_DIR}/radarr" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/radarr"
mkdir -p "${CONFIG_DIR}/bazarr" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/bazarr"
mkdir -p "${CONFIG_DIR}/readarr" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/readarr"
mkdir -p "${CONFIG_DIR}/audiobookshelf" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/audiobookshelf"
mkdir -p "${CONFIG_DIR}/audiobookshelf/metadata" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/audiobookshelf/metadata"

echo "✅ All folders created and ownership set to UID:$PUID and GID:$PGID."
