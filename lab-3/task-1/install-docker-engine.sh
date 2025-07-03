#!/bin/bash

set -e

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

# Use curl with proxy if set
CURL_CMD="curl -fsSL"
if [[ -n "$http_proxy" ]]; then
    CURL_CMD+=" --proxy \"$http_proxy\""
fi

# Download Docker GPG key
eval sudo $CURL_CMD https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) \
signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "📦 Installing docker-engine..."
sudo apt-get update

sudo apt-get install -y \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
    docker-compose-plugin

sudo docker run hello-world

# Add current user to docker group (may require re-login)
sudo usermod -aG docker ${USER}
echo "✅ docker-engine installation is complete!"
