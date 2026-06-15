# Monitoring

You need to add the following environment variables to your `.env` file:

```bash
#VM
PUID=
PGID=

# VPN
VPN_SERVICE_PROVIDER=
VPN_TYPE=
FIREWALL_VPN_INPUT_PORTS=
WIREGUARD_PRIVATE_KEY=
WIREGUARD_PRESHARED_KEY=
WIREGUARD_ADDRESSES=
SERVER_COUNTRIES=
SERVER_CITIES=

# Timezone
TZ=

# Beszel (lightweight monitoring) - filled in after first hub launch
BESZEL_TOKEN=
BESZEL_KEY=
```

---

## Beszel

Lightweight alternative to the Prometheus/Grafana stack. Two services in
`beszel-compose.yaml`: the **hub** (dashboard, `:8090`) and the **agent**
(metrics collector, `host` network so it reads real host stats).

### Setup

1. Start the hub first:

   ```bash
   docker compose -f beszel-compose.yaml up -d beszel
   ```

2. Open `http://<server-ip>:8090`, create the admin account.

3. Click **Add System**. Choose the **Docker** / WebSocket option. The hub
   shows a `TOKEN` and a public `KEY`. Copy both into `.env`:

   ```bash
   BESZEL_TOKEN=<token from hub>
   BESZEL_KEY=ssh-ed25519 AAAA... <key from hub>
   ```

4. Start the agent:

   ```bash
   docker compose -f beszel-compose.yaml up -d beszel-agent
   ```

The system goes green in the hub within ~15s. To monitor extra hosts, run
another `beszel-agent` there with the same `HUB_URL` and its own token/key.
