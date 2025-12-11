#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

echo "Copying Flatpak preinstalls..."

for pak in $(cat /ctx/custom/flatpaks/wqos-flatpaks.list); do
  type=${pak%/*}
  id=${pak#*/}
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
done

echo "Copying custom Flatpak list..."
cp /ctx/custom/flatpaks/wqos-flatpaks.list /etc/ublue-os/wqos-flatpaks.list

echo "Removing unwanted Flatpaks from system list..."
for pak in $(cat /ctx/custom/flatpaks/unwanted-flatpaks.list); do
  grep -v "$pak" /etc/ublue-os/system-flatpaks.list > temp.list
  mv temp.list /etc/ublue-os/system-flatpaks.list
done
