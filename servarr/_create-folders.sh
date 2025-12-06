#!/bin/bash

# Docker Directory Setup Script
# Creates folder structure for Docker containers with proper permissions

set -e  # Exit on error

# Configuration
PUID=${PUID:-1000}
PGID=${PGID:-1000}
CONFIG_DIR="${CONFIG_DIR:-/docker}"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Application directories to create
APPS=(
    # Media Servers
    "plex"
    "jellyfin"

    # Media Management (*arr stack)
    "prowlarr"
    "sonarr"
    "radarr"
    "lidarr"
    "readarr"
    "bazarr"

    # Request Management
    "overseerr"
    "jellyseerr"

    # Analytics & Monitoring
    "tautulli"
    "jellystat"
    "speedtest-tracker"
    "speedtest-tracker-vpn"

    # Specialized Services
    "audiobookshelf"
    "filebrowser"
    "flaresolverr"
    "byparr"
    "glance"
    "plex-meta-manager"

    # Database
    "postgres"
)

# Functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Docker Directory Setup${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
}

print_config() {
    echo -e "${YELLOW}Configuration:${NC}"
    echo "  Base Directory: ${CONFIG_DIR}"
    echo "  User ID (PUID): ${PUID}"
    echo "  Group ID (PGID): ${PGID}"
    echo "  Total Apps: ${#APPS[@]}"
    echo ""
}

create_directories() {
    echo -e "${GREEN}📁 Creating directories...${NC}"
    echo ""

    local created=0
    local skipped=0

    for app in "${APPS[@]}"; do
        local app_dir="${CONFIG_DIR}/${app}"

        if [ -d "$app_dir" ]; then
            echo -e "  ⏭️  ${app} (already exists)"
            ((skipped++))
        else
            mkdir -p "$app_dir"
            echo -e "  ✅ ${app}"
            ((created++))
        fi
    done

    echo ""
    echo -e "${GREEN}Summary:${NC}"
    echo "  Created: ${created}"
    echo "  Skipped: ${skipped}"
    echo ""
}

set_permissions() {
    echo -e "${GREEN}🔐 Setting permissions...${NC}"
    echo ""

    if ! sudo chown -R $PUID:$PGID "${CONFIG_DIR}"; then
        echo -e "${RED}❌ Failed to set permissions${NC}"
        exit 1
    fi

    echo -e "  ✅ Ownership set to ${PUID}:${PGID}"
    echo ""
}

create_docker_network() {
    echo -e "${GREEN}🌐 Checking Docker network...${NC}"

    if docker network ls | grep -q "media-network"; then
        echo -e "  ⏭️  Network 'media-network' already exists"
    else
        docker network create media-network
        echo -e "  ✅ Created network 'media-network'"
    fi
    echo ""
}

verify_setup() {
    echo -e "${GREEN}🔍 Verifying setup...${NC}"
    echo ""

    if [ -d "$CONFIG_DIR" ]; then
        local dir_count=$(find "$CONFIG_DIR" -maxdepth 1 -type d | wc -l)
        echo -e "  ✅ Base directory exists"
        echo -e "  📊 Total subdirectories: $((dir_count - 1))"
    else
        echo -e "${RED}  ❌ Base directory not found${NC}"
        exit 1
    fi
    echo ""
}

print_next_steps() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${GREEN}✅ Setup complete!${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Place your docker-compose.yml files in each directory"
    echo "  2. Configure environment variables"
    echo "  3. Start services with: docker-compose up -d"
    echo ""
    echo -e "${YELLOW}Useful commands:${NC}"
    echo "  List directories: ls -la ${CONFIG_DIR}"
    echo "  Check permissions: ls -ln ${CONFIG_DIR}"
    echo "  View network: docker network inspect media-network"
    echo ""
}

# Main execution
main() {
    print_header
    print_config

    # Check if running with sudo for permission setting
    if [ "$EUID" -ne 0 ] && ! sudo -n true 2>/dev/null; then
        echo -e "${YELLOW}⚠️  This script requires sudo for setting permissions${NC}"
        echo "You may be prompted for your password."
        echo ""
    fi

    # Create base directory if it doesn't exist
    if [ ! -d "$CONFIG_DIR" ]; then
        echo -e "${YELLOW}Creating base directory: ${CONFIG_DIR}${NC}"
        sudo mkdir -p "$CONFIG_DIR"
        echo ""
    fi

    create_directories
    set_permissions

    # Optional: Create Docker network (comment out if not needed)
    if command -v docker &> /dev/null; then
        create_docker_network
    fi

    verify_setup
    print_next_steps
}

# Run main function
main
