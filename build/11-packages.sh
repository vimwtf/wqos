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
  genisoimage
  incus
  incus-agent
  iotop
  libvirt
  libvirt-nss
  lxc
  p7zip
  p7zip-plugins
  podman-compose
  podman-machine
  podman-tui
  qemu
  qemu-char-spice
  qemu-device-display-virtio-gpu
  qemu-device-display-virtio-vga
  qemu-device-usb-redirect
  qemu-img
  qemu-system-x86-core
  qemu-user-binfmt
  qemu-user-static
  tiptop
  util-linux-script
  virt-manager
  virt-v2v
  virt-viewer
)

echo "Installing ${#FEDORA_PACKAGES[@]} DX packages from Fedora repos..."
dnf5 -y install "${FEDORA_PACKAGES[@]}"
