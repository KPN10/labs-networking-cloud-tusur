#!/bin/bash

DOCKER_DESKTOP="distrib/docker-desktop-amd64.deb"
# Docker Desktop download link
LINK="https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"\
"?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64"

set -e

if [ ! -d $DISTRIB_DIR ]; then
    mkdir distrib
fi

if [ ! -f $DOCKER_DESKTOP ]; then
    # Build curl command with optional proxy
    echo "️⬇️ Downloading docker-desktop..."
    CURL_CMD=(curl -L)
    if [[ -n "$http_proxy" ]]; then
        CURL_CMD+=(--proxy "$http_proxy")
    fi

    # Add URL and output file to the command
    CURL_CMD+=("$LINK" -o $DOCKER_DESKTOP)

    # Execute the command
    "${CURL_CMD[@]}"
fi

# Installation
echo "📦 Installing docker-desktop..."
sudo apt update
sudo apt install -y ./$DOCKER_DESKTOP
# systemctl --user start docker-desktop
/opt/docker-desktop/bin/docker-desktop
echo "✅ docker-desktop installation is complete!"
