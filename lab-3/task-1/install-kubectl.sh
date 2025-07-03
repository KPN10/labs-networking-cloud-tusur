#!/bin/bash

VERSION="v1.33.0"
ARCH="amd64"
OS="linux"
DISTRIB_DIR="distrib"

set -e  # Stop execution in case of an error

if [ ! -d $DISTRIB_DIR ]; then
    mkdir distrib
fi

# Download kubectl
if [ ! -f $DISTRIB_DIR/kubectl ]; then
    echo "️⬇️ Downloading kubectl..."
    curl -L "https://dl.k8s.io/release/${VERSION}/bin/${OS}/${ARCH}/kubectl" \
        -o $DISTRIB_DIR/kubectl
fi

# Download sha256
if [ ! -f $DISTRIB_DIR/kubectl.sha256 ]; then
    echo "️⬇️ Downloading kubectl.sha256..."
    curl -L "https://dl.k8s.io/release/${VERSION}/bin/${OS}/${ARCH}/kubectl.sha256" \
        -o $DISTRIB_DIR/kubectl.sha256
fi

cd distrib

# Checking the checksum
echo "🔐 Checking SHA256:"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Installation
chmod +x kubectl
sudo install -o root -g root -m 0755 kubectl /opt/bin/kubectl
# kubectl version
echo "✅ kubectl installation is complete!"
