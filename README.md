# Loam Runbook

Operations guide for Loam running on Raspberry Pi 4B.

---

## What's Running

| Service | How it runs | Auto-start |
|---|---|---|
| Moltis (agent harness) | systemd user service | ✅ on boot |
| signal-cli | Docker + systemd user service | ✅ after Moltis |

**Pi specs:** Raspberry Pi 4B, 2GB RAM, SD card boot — no swap (intentional)

---

## Accessing the Pi

Via Tailscale — no SSH tunnel needed:

```
https://raspberrypi.tail5f32a0.ts.net/settings/identity
```

---

## Checking Status

```bash
# Moltis
systemctl --user status [TODO: moltis service name]

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
# Restart Moltis (signal-cli keeps running)
systemctl --user restart [TODO: moltis service name]

# Restart signal-cli
systemctl --user restart signal-cli.service

# Restart both (full cycle)
systemctl --user restart [TODO: moltis service name]
systemctl --user restart signal-cli.service
```

---

## Updating Moltis

```bash
ssh loam@raspberrypi
[TODO: update procedure / script]
```

---

## Boot Sequence

On a fresh boot, systemd handles everything automatically:

1. `[TODO: moltis service name]` starts (after `network-online.target`)
2. `signal-cli.service` starts (after Moltis)
   - Waits for Moltis's health endpoint before starting Docker container

**Nothing manual needed after a reboot.**

---

## Troubleshooting

### Moltis won't start / keeps crashing
```bash
journalctl --user -u [TODO: moltis service name] -n 50
```
Check for OOM kills: `dmesg | grep -i "killed process"`

### Signal CLI not receiving messages
```bash
docker logs signal-cli-daemon --tail 50
docker restart signal-cli-daemon
systemctl --user restart signal-cli.service
```

---

## File Locations

| File | Path |
|---|---|
| Moltis config | `[TODO]` |
| Moltis service | `~/.config/systemd/user/[TODO: moltis service name]` |
| Signal CLI service | `~/.config/systemd/user/signal-cli.service` |
| Start signal script | `~/scripts/start-signal.sh` |
| Agent workspace | `[TODO]` |
| Signal CLI data | `~/.local/share/signal-cli-rest-api/` |
