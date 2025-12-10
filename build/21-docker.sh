#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

echo "Installing Docker..."
  
dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/docker-ce.repo
dnf5 -y install --enablerepo=docker-ce-stable \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    docker-model-plugin

# Clean up repo file
rm -f /etc/yum.repos.d/docker-ce.repo

echo "Docker installation complete."
