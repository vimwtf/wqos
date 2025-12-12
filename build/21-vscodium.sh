#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

echo "Installing VSCodium..."

tee /etc/yum.repos.d/vscodium.repo <<'EOF'
[vscodium]
name=VSCodium
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF
dnf5 -y install --enablerepo=vscodium codium
  
# Clean up repo file
rm -f /etc/yum.repos.d/vscodium.repo

echo "VSCodium installation complete."
