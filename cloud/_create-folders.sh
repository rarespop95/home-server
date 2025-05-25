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

mkdir -p "${CONFIG_DIR}/immich" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/immich"
mkdir -p "${CONFIG_DIR}/immich/cache" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/immich/cache"
mkdir -p "${CONFIG_DIR}/immich/db" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/immich/db"

mkdir -p "${CONFIG_DIR}/nextcloud" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/nextcloud"
mkdir -p "${CONFIG_DIR}/nextcloud/db" && sudo chown -R $PUID:$PGID "${CONFIG_DIR}/nextcloud/db"

echo "✅ All folders created and ownership set to UID:$PUID and GID:$PGID."
