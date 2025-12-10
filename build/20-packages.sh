#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

FEDORA_PACKAGES=(
  cascadia-code-fonts
  cockpit-bridge
  cockpit-machines
  cockpit-networkmanager
  cockpit-ostree
  cockpit-podman
  cockpit-selinux
  cockpit-storaged
  cockpit-system
  libvirt
  libvirt-nss
  podman-compose
  podman-machine
  podman-tui
  incus
  incus-agent
  lxc
)

echo "Installing ${#FEDORA_PACKAGES[@]} DX packages from Fedora repos..."
dnf5 -y install "${FEDORA_PACKAGES[@]}"
