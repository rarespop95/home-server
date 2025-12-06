# System Update and Maintenance Guide

Follow these steps to update and maintain your system efficiently.

---

## ✅ Step 1: Update Package List

Run the following command to refresh your local list of available updates:

```bash
sudo apt update
```

<hr>

## ✅ Step 2: Upgrade All Packages

To install all available updates, use:

```bash
sudo apt upgrade -y
```

For a more comprehensive upgrade (handles package removals or installs required for upgrades), use:

```bash
sudo apt full-upgrade -y
```

<hr>

## ✅ Step 3: Clean Up Unused Packages

Remove unused packages and clean up your system with:

```bash
sudo apt autoremove -y
sudo apt autoclean
```

<hr>

## ✅ Step 4: Reboot if a New Kernel is Installed

If you see output like this during the upgrade:

```bash
The following packages will be upgraded:
linux-image-6.8.0-... linux-modules-6.8.0-...
```

You need to reboot your system. Use the following command:

```bash
sudo reboot
```

To check if a reboot is required, run:

```bash
[ -f /var/run/reboot-required ] && echo "Reboot required"
```

<hr>

## 🧪 Optional: Check Release Version

To verify your current release version, run:

```bash
lsb_release -a
linux-image-6.8.0-... linux-modules-6.8.0-...
```



# Portainer Update Guide

## Updating Portainer Running via Docker

This guide covers the most common scenario where Portainer is running as a Docker container.

### Step 1: Pull the Latest Portainer Image

```bash
docker pull portainer/portainer-ce:latest
```

### Step 2: Stop and Remove the Existing Container

**Important:** This does NOT delete your data. Your data is safely stored in your mounted volume (`/data`).

```bash
docker stop portainer
docker rm portainer
```

### Step 3: Start Portainer with the Updated Image

#### Standard Installation

If you originally installed Portainer using the standard command:

```bash
docker run -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
```

#### Custom Volume Path

If your installation uses a custom volume path, replace `portainer_data` with your specific volume path (e.g., `/srv/portainer/data`).

```bash
docker run -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /srv/portainer/data:/data \
  portainer/portainer-ce:latest
```

---

## Verification

After completing the steps, verify that Portainer is running:

```bash
docker ps | grep portainer
```

You can then access Portainer at `https://your-server-ip:9443`
