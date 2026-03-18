# Loam Runbook

Operations guide for the Loam AI assistant running on Raspberry Pi 4B.

---

## What's Running

| Service | How it runs | Auto-start |
|---|---|---|
| OpenClaw gateway | systemd user service | ✅ on boot |
| signal-cli | Docker + systemd user service | ✅ after OpenClaw |

**Pi specs:** Raspberry Pi 4B, 2GB RAM, SD card boot — no swap (intentional)

**Memory cap:** OpenClaw is capped at 768MB (`NODE_OPTIONS=--max-old-space-size=768`) to leave headroom for Docker and the OS.

---

## Accessing the Dashboard

From your Mac:

```bash
# 1. SSH into the Pi
ssh loam@raspberrypi

# 2. In a second terminal tab — forward the dashboard port
ssh -N -L 18789:127.0.0.1:18789 loam@2605:a601:aae0:6d00::3

# 3. Open in browser
open http://localhost:18789
```

---

## Checking Status

```bash
# OpenClaw
systemctl --user status openclaw-gateway.service

# Signal CLI
systemctl --user status signal-cli.service
docker ps | grep signal

# Memory usage
free -h
docker stats signal-cli-daemon --no-stream
```

---

## Restarting Services

```bash
# Restart OpenClaw (signal-cli keeps running)
systemctl --user restart openclaw-gateway.service

# Restart signal-cli
systemctl --user restart signal-cli.service

# Restart both (full cycle)
systemctl --user restart openclaw-gateway.service
systemctl --user restart signal-cli.service
```

---

## Updating OpenClaw

**Always use the update script** — it preserves the memory cap that gets wiped on a plain `pnpm` update.

```bash
ssh loam@raspberrypi
~/scripts/update-openclaw.sh          # latest
~/scripts/update-openclaw.sh 2026.4.1  # specific version
```

The script:
1. Backs up the current service file
2. Stops OpenClaw
3. Installs the new version via pnpm
4. Re-registers the systemd service
5. Reapplies the 768MB memory cap
6. Restarts OpenClaw

---

## Boot Sequence

On a fresh boot, systemd handles everything automatically:

1. `openclaw-gateway.service` starts (after `network-online.target`)
2. `signal-cli.service` starts (after `openclaw-gateway.service`)
   - Waits for OpenClaw's `/health` endpoint before starting Docker container

**Nothing manual needed after a reboot.**

---

## Troubleshooting

### OpenClaw won't start / keeps crashing
```bash
journalctl --user -u openclaw-gateway.service -n 50
```
Check for OOM kills: `dmesg | grep -i "killed process"`

### Signal CLI not receiving messages
```bash
docker logs signal-cli-daemon --tail 50
docker restart signal-cli-daemon
systemctl --user restart signal-cli.service
```

### Dashboard unreachable from Mac
- Confirm the SSH tunnel is running (second terminal tab)
- Confirm OpenClaw is up: `systemctl --user status openclaw-gateway.service`
- Try: `curl http://127.0.0.1:18789/health` from the Pi

### Memory pressure
```bash
free -h
docker stats signal-cli-daemon --no-stream
journalctl --user -u openclaw-gateway.service --since "1 hour ago" | grep -i memory
```

---

## File Locations

| File | Path |
|---|---|
| OpenClaw config | `~/.openclaw/openclaw.json` |
| OpenClaw service | `~/.config/systemd/user/openclaw-gateway.service` |
| Signal CLI service | `~/.config/systemd/user/signal-cli.service` |
| Start signal script | `~/scripts/start-signal.sh` |
| Update script | `~/scripts/update-openclaw.sh` |
| Agent workspace | `~/.openclaw/workspace/` |
| Signal CLI data | `~/.local/share/signal-cli-rest-api/` |

---

## After Updating OpenClaw — Verify Memory Cap

```bash
grep NODE_OPTIONS ~/.config/systemd/user/openclaw-gateway.service
# Should output: Environment=NODE_OPTIONS=--max-old-space-size=768
# If missing, run: ~/scripts/update-openclaw.sh (it reapplies it)
```
