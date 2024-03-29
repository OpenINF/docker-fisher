#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Copyright (c) The OpenINF Authors & Friends. All rights reserved.
# License: MIT OR Apache-2.0 OR BlueOak-1.0.0
# ------------------------------------------------------------------------------
#
# ** This script is community supported **
# Docs: https://github.com/OpenINF/docker-fisher/blob/HEAD/library-scripts/docs/common-centos7.md
# Maintainer: The OpenINF Community - https://open.inf.is/community
#
# Syntax: ./common-centos7.sh [username] [user UID] [user GID] [upgrade packages flag] [Add non-free packages]

set -e

USERNAME=${1:-"automatic"}
USER_UID=${2:-"automatic"}
USER_GID=${3:-"automatic"}
UPGRADE_PACKAGES=${4:-"true"}
ADD_NON_FREE_PACKAGES=${5:-"false"}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARKER_FILE="/usr/local/etc/vscode-dev-containers/common"
