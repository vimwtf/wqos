#!/usr/bin/bash

set -eoux pipefail

###############################################################################
# Main Build Script
###############################################################################
# This script follows the @ublue-os/bluefin pattern for build scripts.
# It uses set -eoux pipefail for strict error handling and debugging.
###############################################################################

# Source helper functions
# shellcheck source=/dev/null
source /ctx/build/copr-helpers.sh

echo "::group:: Copy Custom Files"

# Copy system files
rsync -rvK /ctx/custom/system_files/ /

mkdir -p /tmp/scripts/helpers
install -Dm0755 /ctx/build/ghcurl /tmp/scripts/helpers/ghcurl
export PATH="/tmp/scripts/helpers:$PATH"

# Copy Brewfiles to standard location
mkdir -p /usr/share/ublue-os/homebrew/
cp /ctx/custom/brew/*.Brewfile /usr/share/ublue-os/homebrew/

# Consolidate Just Files
mkdir -p /usr/share/ublue-os/just/
find /ctx/custom/ujust -iname '*.just' -exec printf "\n\n" \; -exec cat {} \; >> /usr/share/ublue-os/just/60-custom.just

echo "::endgroup::"

# Preload Flatpaks
/ctx/build/15-flatpaks.sh

# Install additional packages
/ctx/build/20-packages.sh

# Install Docker
/ctx/build/21-docker.sh

# Install VSCodium
/ctx/build/22-vscodium.sh

echo "::group:: System Configuration"

# Enable/disable systemd services
systemctl enable docker.socket
systemctl enable podman.socket
systemctl enable swtpm-workaround.service
systemctl enable libvirt-workaround.service
systemctl enable dx-groups.service
# Example: systemctl mask unwanted-service

# Ensure all repos are disabled
/ctx/build/validate-repos.sh

# Cleanup
/ctx/build/clean-stage.sh

echo "Custom build complete!"
