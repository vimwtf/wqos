#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

echo "Installing VSCode..."

tee /etc/yum.repos.d/vscode.repo <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
dnf5 -y install --enablerepo=code \
    code
  
# Clean up repo file
rm -f /etc/yum.repos.d/vscode.repo

echo "VSCode installation complete."
