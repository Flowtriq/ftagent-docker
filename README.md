# ftagent-docker

[![Docker Hub](https://img.shields.io/docker/v/flowtriq/ftagent?label=Docker%20Hub&sort=semver)](https://hub.docker.com/r/flowtriq/ftagent)
[![Docker Pulls](https://img.shields.io/docker/pulls/flowtriq/ftagent)](https://hub.docker.com/r/flowtriq/ftagent)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Docker packaging for **[ftagent](https://github.com/Flowtriq/ftagent)**, the Flowtriq DDoS detection agent. Provides real-time traffic monitoring, attack detection, PCAP capture, and auto-mitigation for Linux servers running in containerized environments.

A valid [Flowtriq](https://flowtriq.com) account and API key are required. Start a free 14-day trial at [flowtriq.com](https://flowtriq.com).

---

## Quick Start

```bash
docker run -d \
  --name ftagent \
  --network host \
  --cap-add NET_RAW \
  --cap-add NET_ADMIN \
  -e FTAGENT_API_KEY=your_api_key \
  -e FTAGENT_NODE_UUID=your_node_uuid \
  flowtriq/ftagent
```

## Docker Compose

```yaml
services:
  ftagent:
    image: flowtriq/ftagent:latest
    container_name: ftagent
    restart: unless-stopped
    network_mode: host
    cap_add:
      - NET_RAW
      - NET_ADMIN
    environment:
      - FTAGENT_API_KEY=your_api_key
      - FTAGENT_NODE_UUID=your_node_uuid
      - FTAGENT_INTERFACE=eth0
    volumes:
      - ftagent-data:/var/lib/ftagent
      - ftagent-logs:/var/log/ftagent

volumes:
  ftagent-data:
  ftagent-logs:
```

A ready-to-use `docker-compose.yml` is included in this repository. Copy `.env.example` or set the environment variables directly.

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `FTAGENT_API_KEY` | Yes | -- | Your Flowtriq API key |
| `FTAGENT_NODE_UUID` | Yes | -- | Node UUID from your Flowtriq dashboard |
| `FTAGENT_INTERFACE` | No | `eth0` | Network interface to monitor |
| `FTAGENT_API_URL` | No | `https://api.flowtriq.com` | API endpoint |

## Config File Mount

Alternatively, mount your own config file instead of using environment variables:

```bash
docker run -d \
  --name ftagent \
  --network host \
  --cap-add NET_RAW \
  --cap-add NET_ADMIN \
  -v /path/to/config.json:/etc/ftagent/config.json \
  flowtriq/ftagent
```

## Requirements

- `--network host` is required for the agent to see real network traffic
- `NET_RAW` and `NET_ADMIN` capabilities are required for packet capture
- A Flowtriq account with an API key and Node UUID

## Getting Your API Key

1. Sign up at [flowtriq.com](https://flowtriq.com)
2. Go to **Dashboard** > **Nodes** > **Add Node**
3. Copy the API key and Node UUID

## Image Tags

- `latest` -- latest stable release
- `x.y.z` -- specific version (e.g., `1.9.10`)

## Building Locally

```bash
git clone https://github.com/Flowtriq/ftagent-docker.git
cd ftagent-docker
docker build -t ftagent .
```

## Links

- [Flowtriq Website](https://flowtriq.com)
- [ftagent on GitHub](https://github.com/Flowtriq/ftagent)
- [Documentation](https://flowtriq.com/docs)
- [Support](mailto:hello@flowtriq.com)

## License

MIT License. See [LICENSE](LICENSE) for details.
