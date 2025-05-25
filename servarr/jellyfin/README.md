# Jellyfin

You need to add the following environment variables to your `.env` file:

```bash
#VM
PUID=
PGID=

# Jellyfin
JELLYFIN_POSTGRES_USER=
JELLYFIN_POSTGRES_PASSWORD=
JELLYFIN_JWT_SECRET=

# Timezone
TZ=
```
## Enable NVIDIA Transcoding for Jellyfin

This guide will help you set up NVIDIA GPU hardware acceleration for Jellyfin to improve transcoding performance. Hardware acceleration significantly reduces CPU usage when streaming media that requires transcoding.

### Prerequisites

- A compatible NVIDIA GPU
- Jellyfin installed in a Docker container
- Ubuntu or Debian-based Linux distribution
- Root or sudo access

### Step 1: Install NVIDIA Drivers

First, ensure you have NVIDIA drivers installed on your host system. The specific installation method depends on your distribution, but you can generally install them through your package manager.

### Step 2: Install NVIDIA Container Toolkit

The NVIDIA Container Toolkit allows Docker containers to access the GPU for hardware acceleration.

1. Add the NVIDIA Container Toolkit repository:

```bash
# Detect your distribution
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

# If the above command doesn't work, manually set your distribution
# For Ubuntu 24.04, use:
# distribution=ubuntu22.04

# Add repository and GPG key
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sed 's#deb #deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] #' | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

> **Note:** If you're using Ubuntu 24.04 (noble), you may need to manually set `distribution=ubuntu22.04` as NVIDIA might not have a repository specifically for 24.04 yet.

2. Install the NVIDIA Container Toolkit:

```bash
sudo apt update
sudo apt install -y nvidia-container-toolkit
sudo systemctl restart docker
```

### Step 3: Configure Docker to Use NVIDIA Runtime

1. Create or edit the Docker daemon configuration file:

```bash
sudo nano /etc/docker/daemon.json
```

2. Add the NVIDIA runtime configuration:

```json
{
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  }
}
```

> **Note:** If the file already exists with other settings, make sure to merge the configurations properly without overwriting existing settings.

3. Restart Docker to apply the changes:

```bash
sudo systemctl restart docker
```

### Step 4: Update Jellyfin Docker Configuration

1. Update your docker-compose.yml to include the NVIDIA runtime and device access:

```
    runtime: nvidia
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

2. Restart your Jellyfin container:

```bash
docker-compose down && docker-compose up -d
# or
docker restart jellyfin
```

### Step 5: Enable Hardware Acceleration in Jellyfin

1. Open the Jellyfin web interface and log in as an administrator
2. Go to Admin > Dashboard > Playback
3. In the "Transcoding" section:
    - Enable "Hardware acceleration"
    - Select "NVIDIA NVENC" as the hardware acceleration method
4. Save your changes

### Verification

To verify that NVIDIA transcoding is working:

1. Play a video that requires transcoding
2. Check the Jellyfin logs for entries containing "NVENC" or "hardware"
3. Monitor GPU usage with `nvidia-smi` while playing the video

## Additional Resources

- [Jellyfin Documentation - Hardware Acceleration](https://jellyfin.org/docs/general/administration/hardware-acceleration/)
- [NVIDIA Container Runtime GitHub](https://github.com/NVIDIA/nvidia-container-runtime)
