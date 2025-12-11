#!/usr/bin/bash

source /usr/lib/ublue/setup-services/libsetup.sh

version-script vscodium user 1 || exit 1

set -x

# Setup VSCodium
if test ! -e "$HOME"/.config/VSCodium/User/settings.json; then
	mkdir -p "$HOME"/.config/VSCodium/User
	cp -f /etc/skel/.config/VSCodium/User/settings.json "$HOME"/.config/VSCodium/User/settings.json
fi

codium --install-extension ms-vscode-remote.remote-containers
codium --install-extension ms-vscode-remote.remote-ssh
codium --install-extension ms-azuretools.vscode-containers