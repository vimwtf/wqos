#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

echo "Copying Flatpak preinstalls..."
mkdir -p /etc/flatpak/preinstall.d/
while IFS= read -r line; do
  type=${line%/*}
  id=${line#*/}
  if [ "$type" == "runtime" ]; then
    tee -a /etc/flatpak/preinstall.d/default.preinstall <<EOF
[Flatpak Preinstall $id]
Branch=stable
IsRuntime=true

EOF
  else
    tee -a /etc/flatpak/preinstall.d/default.preinstall <<EOF
[Flatpak Preinstall $id]
Branch=stable

EOF
  fi
done < /ctx/custom/flatpaks/wqos-flatpaks.list

echo "Copying custom Flatpak list..."
cp /ctx/custom/flatpaks/wqos-flatpaks.list /etc/ublue-os/wqos-flatpaks.list

echo "Removing unwanted Flatpaks from system list..."
while IFS= read -r line; do
  grep -v "$line" /etc/ublue-os/system-flatpaks.list > temp.list
  mv temp.list /etc/ublue-os/system-flatpaks.list
done < /ctx/custom/flatpaks/unwanted-flatpaks.list
