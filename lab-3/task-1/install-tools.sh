#!/bin/bash

set -e
./install-docker-engine.sh
./install-docker-desktop.sh
./install-kubectl.sh
./install-minikube.sh
echo "✅ All the tools are installed!"
