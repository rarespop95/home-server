# Docker Directory Structure
## Overview

This repository contains Docker configurations for a comprehensive media server and automation setup.

## Directory Structure

```
/docker/
├── audiobookshelf          # Audiobook and podcast server
├── bazarr                  # Subtitle management
├── byparr                  # Bypass manager for *arr apps
├── filebrowser             # Web-based file manager
├── flaresolverr            # Proxy server for Cloudflare-protected sites
├── glance                  # Dashboard
├── jellyfin                # Media server
├── jellyseerr              # Media request management for Jellyfin
├── jellystat               # Jellyfin statistics and analytics
├── lidarr                  # Music collection manager
├── overseerr               # Media request management for Plex
├── plex                    # Media server
├── plex-meta-manager       # Plex metadata and collection manager
├── postgres                # PostgreSQL database
├── prowlarr                # Indexer manager
├── radarr                  # Movie collection manager
├── readarr                 # Book and audiobook manager
├── sonarr                  # TV series collection manager
├── speedtest-tracker       # Internet speed monitoring
├── speedtest-tracker-vpn   # Internet speed monitoring via VPN
└── tautulli                # Plex analytics and monitoring
```

## Services by Category

### Media Servers
- **Plex** - Feature-rich media server
- **Jellyfin** - Open-source media server

### Media Management
- **Radarr** - Automated movie downloads and organization
- **Sonarr** - Automated TV show downloads and organization
- **Lidarr** - Automated music downloads and organization
- **Readarr** - Automated book and audiobook management
- **Prowlarr** - Centralized indexer management for all *arr apps

### Media Enhancement
- **Bazarr** - Automated subtitle downloads
- **Plex Meta Manager** - Custom collections and metadata for Plex

### Request Management
- **Overseerr** - User request system for Plex
- **Jellyseerr** - User request system for Jellyfin

### Analytics & Monitoring
- **Tautulli** - Plex usage statistics and monitoring
- **Jellystat** - Jellyfin usage statistics and monitoring
- **Speedtest Tracker** - Regular internet speed tests
- **Speedtest Tracker VPN** - Speed tests through VPN connection

### Specialized Services
- **Audiobookshelf** - Dedicated audiobook and podcast server
- **Filebrowser** - Web-based file management interface
- **Glance** - Dashboard for quick overview
- **FlareSolverr** - Bypass Cloudflare protection for indexers
- **Byparr** - Additional bypass management
- **PostgreSQL** - Database backend for services


## Getting Started

### Prerequisites

- Docker and Docker Compose installed
- Sudo privileges (for setting directory permissions)
- Basic understanding of Docker containers

### Quick Setup

#### 1. Clone or Download the Setup Script

Download the `setup-docker-dirs.sh` script to your server.

#### 2. Make the Script Executable

```bash
chmod +x setup-docker-dirs.sh
```

#### 3. Run the Setup Script

**Basic usage** (uses defaults: PUID=1000, PGID=1000, /docker):

```bash
./setup-docker-dirs.sh
```

**With custom user/group IDs:**

```bash
PUID=1001 PGID=1001 ./setup-docker-dirs.sh
```

**With custom base directory:**

```bash
CONFIG_DIR=/mnt/docker ./setup-docker-dirs.sh
```

**With all custom settings:**

```bash
PUID=1001 PGID=1001 CONFIG_DIR=/mnt/docker ./setup-docker-dirs.sh
```

#### 4. What the Script Does

The setup script will automatically:

- ✅ Create all required directories under `/docker/` (or your custom path)
- ✅ Set proper ownership (PUID:PGID) for all directories
- ✅ Create a Docker network named `media-network` for inter-container communication
- ✅ Verify the setup completed successfully
- ✅ Display a summary of created directories

#### 5. Find Your User and Group IDs

If you're unsure of your PUID and PGID:

```bash
id
```

This will display something like: `uid=1000(username) gid=1000(groupname)`

### Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PUID` | 1000 | User ID for directory ownership |
| `PGID` | 1000 | Group ID for directory ownership |
| `CONFIG_DIR` | /docker | Base directory for all containers |
