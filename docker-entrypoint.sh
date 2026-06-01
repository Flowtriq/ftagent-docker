#!/bin/bash
set -e

# Generate config from environment variables if no config file exists
if [ ! -f "$FTAGENT_CONFIG" ] && [ -n "$FTAGENT_API_KEY" ]; then
    cat > "$FTAGENT_CONFIG" <<EOF
{
    "api_key": "$FTAGENT_API_KEY",
    "node_uuid": "${FTAGENT_NODE_UUID:-}",
    "interface": "${FTAGENT_INTERFACE:-eth0}",
    "api_url": "${FTAGENT_API_URL:-https://api.flowtriq.com}"
}
EOF
    echo "Config generated from environment variables."
fi

if [ ! -f "$FTAGENT_CONFIG" ] && [ -z "$FTAGENT_API_KEY" ] && [ "$1" = "ftagent" ]; then
    echo "ERROR: No config found. Mount a config file to $FTAGENT_CONFIG or set FTAGENT_API_KEY environment variable."
    echo ""
    echo "Usage:"
    echo "  docker run -e FTAGENT_API_KEY=your_key -e FTAGENT_NODE_UUID=your_uuid flowtriq/ftagent"
    echo ""
    echo "  or mount a config:"
    echo "  docker run -v /path/to/config.json:/etc/ftagent/config.json flowtriq/ftagent"
    exit 1
fi

exec "$@"
