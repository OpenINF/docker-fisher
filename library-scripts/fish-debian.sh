#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) The OpenINF Authors. All rights reserved.
# Dual licensed under MIT/Apache-2.0. See the LICENSE.md file at the root of the source tree for more info.
#-------------------------------------------------------------------------------------------------------------
#
# ** This script is community supported **
# Docs: https://github.com/OpenINF/docker-fisher/blob/HEAD/library-scripts/docs/fish-debian.md
# Maintainer: The OpenINF Community
#
# Syntax: ./fish-debian.sh [whether to install Fisher] [non-root user]

INSTALL_FISHER=${1:-"true"}
USERNAME=${2:-"automatic"}

set -e

if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# Determine the appropriate non-root user
if [ "$USERNAME" = "auto" ] || [ "$USERNAME" = "automatic" ]; then
  USERNAME=""
  POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
  for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
    if id -u "$CURRENT_USER" >/dev/null 2>&1; then
      USERNAME=$CURRENT_USER
      break
    fi
  done
  if [ "$USERNAME" = "" ]; then
    USERNAME=root
  fi
elif [ "$USERNAME" = "none" ] || ! id -u "$USERNAME" >/dev/null 2>&1; then
  USERNAME=root
fi

# Function to run apt-get if needed
apt_get_update_if_needed() {
  if [ ! -d "/var/lib/apt/lists" ] || [ $(($(wc -c <"/var/lib/apt/lists/"))) = "0" ]; then
    echo "Running apt-get update..."
    apt-get update
  else
    echo "Skipping apt-get update"
  fi
}

# Checks if packages are installed and installs them if not
check_packages() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
    apt_get_update_if_needed
    apt-get -y install --no-install-recommends "$@"
  fi
}

check_packages curl ca-certificates gnupg2 apt-transport-https

# Install fish shell
echo "Installing fish shell..."
if grep -q 'Ubuntu' </etc/os-release; then
  check_packages software-properties-common
  apt-get -y update
  apt-get -y install fish
  apt-get -y autoremove
elif grep -q 'Debian' </etc/os-release; then
  if grep -q 'stretch' </etc/os-release; then
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_9.0/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_9.0/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg >/dev/null
  elif grep -q 'buster' </etc/os-release; then
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg >/dev/null
  elif grep -q 'bullseye' </etc/os-release; then
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg >/dev/null
  fi
  apt-get -y update
  apt-get -y install --no-install-recommends fish
  apt-get -y autoremove
fi

fish -v

# Install Fisher
if [ "$INSTALL_FISHER" = "true" ]; then
  echo "Installing Fisher..."
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
  if [ "$USERNAME" != "root" ]; then
    sudo -u "$USERNAME" fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
  fi
  fish -c "fisher -v"
fi

echo "Done!"
