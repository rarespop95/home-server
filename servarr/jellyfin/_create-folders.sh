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

mkdir -p "${CONFIG_DIR}/jellyfin" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/jellyfin"
mkdir -p "${CONFIG_DIR}/jellyfin/transcode" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/jellyfin/transcode"
mkdir -p "${CONFIG_DIR}/jellyseerr" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/jellyseerr"
mkdir -p "${CONFIG_DIR}/jellystat" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/jellystat"
mkdir -p "${CONFIG_DIR}/jellystat/db" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/jellystat/db"

echo "✅ All folders created and ownership set to UID:$PUID and GID:$PGID."


