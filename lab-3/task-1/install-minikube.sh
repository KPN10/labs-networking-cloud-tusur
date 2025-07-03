#!/bin/bash

ARCH="amd64"
OS="linux"
DEST="/opt/bin"
URL_BASE="https://storage.googleapis.com/minikube/releases/latest"
DISTRIB_DIR="distrib"

set -e

if [ ! -d $DISTRIB_DIR ]; then
    mkdir distrib
fi

# Download
if [ ! -f $DISTRIB_DIR/minikube ]; then
    echo "⬇️ Downloading minikube..."
    curl -L "${URL_BASE}/minikube-${OS}-${ARCH}" -o $DISTRIB_DIR/minikube
fi

# Installation
cd distrib
echo "📦 Installing minikube in a ${DEST}..."
chmod +x "minikube"
sudo cp "minikube" "${DEST}/minikube"

# Checking the installation
minikube version
echo "✅ minikube inatallation is complete!"
