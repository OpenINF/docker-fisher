#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) The OpenINF Authors. All rights reserved.
# Dual licensed under MIT/Apache-2.0. See the LICENSE.md file at the root of the source tree for more info.
#-------------------------------------------------------------------------------------------------------------
#
# ** This script is community supported **
# Docs: https://github.com/OpenINF/docker-fisher/blob/HEAD/library-scripts/docs/ruby-debian.md
# Maintainer: The OpenINF Community
#
# Syntax: ./ruby-debian.sh [Ruby version] [non-root user] [Add to rc files flag]

RUBY_VERSION=${1:-"latest"}
USERNAME=${2:-"automatic"}
UPDATE_RC=${3:-"true"}

# This script checks to see if the script is being run as root.
# If the script is not being run as root, then the script prints an error message and exits.

# Set the fail-fast option.
set -e

# Get the current user ID.
CURRENT_USER_ID=$(id -u)

# Check to see if the current user is root.
if [ "$CURRENT_USER_ID" -ne 0 ]; then
  # Print an error message and exit.
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

# Ensure that login shells get the correct path if the user updated the PATH using ENV.

# Remove the existing 00-restore-env.sh file.
rm -f /etc/profile.d/00-restore-env.sh

# Create a new 00-restore-env.sh file.
echo "export PATH=${PATH//$(sh -lc 'echo $PATH')/\$PATH}" > /etc/profile.d/00-restore-env.sh

# Change the permissions of the 00-restore-env.sh file to make it executable.
chmod +x /etc/profile.d/00-restore-env.sh

# Determine the appropriate non-root user.

# Get the username from the environment, if it is set.
if [[ -z "${USERNAME}" ]]; then
  # If the username is not set, get the username of the user who has a UID of 1000.
  USERNAME=$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)
fi

# If the username is still empty, set it to "root".
if [[ -z "${USERNAME}" ]]; then
  USERNAME="root"
fi

# Print the username.
echo "The username is: ${USERNAME}"

# Appends a line of code to the Fish shell dotfile.
#
# Arguments:
# * line: The line of code to append.
#
# Returns:
# Nothing.
updaterc() {
    if [ "${UPDATE_RC}" = "true" ]; then
        echo "Updating /etc/fish/config.fish..."
        if [ ! -f "/etc/fish/config.fish" ]; then
            echo -e "$1" > /etc/fish/config.fish
        fi
        if [[ "$(cat /etc/fish/config.fish)" != *"$1"* ]]; then
            echo -e "$1" >> /etc/fish/config.fish
        fi
    fi
}

# Executes a command with sudo privileges if the current user is not root.
#
# Arguments:
# * command: The command to execute.
#
# Returns:
# The output of the command.
sudo_if() {
    COMMAND="$*"
    if [ "$(id -u)" -eq 0 ] && [ "$USERNAME" != "root" ]; then
        su - "$USERNAME" -c "$COMMAND"
    else
        "$COMMAND"
    fi
}

# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

download_with_retries() {
# Due to restrictions of bash functions, positional arguments are used here.
# In case if you using latest argument NAME, you should also set value to all previous parameters.
# Example: download_with_retries $ANDROID_SDK_URL "." "android_sdk.zip"
    local URL="$1"
    local DEST="${2:-.}"
    local NAME="${3:-${URL##*/}}"
    local COMPRESSED="$4"

    if [[ $COMPRESSED == "compressed" ]]; then
        local COMMAND="curl $URL -4 -sL --compressed -o '$DEST/$NAME' -w '%{http_code}'"
    else
        local COMMAND="curl $URL -4 -sL -o '$DEST/$NAME' -w '%{http_code}'"
    fi

    echo "Downloading '$URL' to '${DEST}/${NAME}'..."
    retries=20
    interval=30
    while [ $retries -gt 0 ]; do
        ((retries--))
        # Temporary disable exit on error to retry on non-zero exit code
        set +e
        http_code=$(eval "$COMMAND")
        exit_code=$?
        set -e
        if [ "$http_code" -eq 200 ] && [ $exit_code -eq 0 ]; then
            echo "Download completed"
            return 0
        else
            echo "Error — Either HTTP response code for '$URL' is wrong - '$http_code' or exit code is not 0 - '$exit_code'. Waiting $interval seconds before the next attempt, $retries attempts left"
            sleep $interval
        fi
    done

    echo "Could not download $URL"
    return 1
}

echo "Install Ruby from toolset..."
export RUNNER_TOOL_CACHE=/opt/hostedtoolcache
TOOLSET_VERSION=$RUBY_VERSION
PLATFORM_VERSION="22.04"
TARBALL_NAME=ruby-${TOOLSET_VERSION}-ubuntu-${PLATFORM_VERSION}.tar.gz
RUBY_PATH="$RUNNER_TOOL_CACHE/Ruby"
# RUBY_VERSION=$(echo "$TARBALL_NAME" | cut -d'-' -f 2)
RUBY_VERSION_PATH="$RUBY_PATH/$RUBY_VERSION"

# Define the RBENV_ROOT variable.
RBENV_ROOT=/home/$USERNAME/.rbenv

echo "Check if Ruby hostedtoolcache folder exist..."
if [ ! -d $RUBY_PATH ]; then
    mkdir -p $RUBY_PATH
fi

echo "Create Ruby $RUBY_VERSION directory..."
mkdir -p "$RUBY_VERSION_PATH"
chmod 755 "$RUBY_VERSION_PATH"

echo "Downloading tar archive $PACKAGE_TAR_NAME"
DOWNLOAD_URL="https://github.com/ruby/ruby-builder/releases/download/toolcache/$TARBALL_NAME"
download_with_retries "$DOWNLOAD_URL" "/tmp" "$TARBALL_NAME"

echo "Expand '$TARBALL_NAME' to the '$RUBY_VERSION_PATH' folder"
tar -xzf "/tmp/$TARBALL_NAME" -C "$RUBY_VERSION_PATH"

COMPLETE_FILE_PATH="$RUBY_VERSION_PATH/x64.complete"
if [ ! -f "$COMPLETE_FILE_PATH" ]; then
    echo "Create complete file"
    touch "$COMPLETE_FILE_PATH"
fi

# Install rbenv/ruby-build for good measure
sudo_if git clone --depth=1 \
    -c core.eol=lf \
    -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    https://github.com/rbenv/rbenv.git "$RBENV_ROOT"

# Add rbenv to fish user PATH while in fish shell.
updaterc "set rbenv_root \$HOME/.rbenv"
updaterc "set -Ux fish_user_paths \$rbenv_root/bin \$fish_user_paths"
updaterc "status --is-interactive; and rbenv init - fish | source"

if [ "${USERNAME}" != "root" ]; then
    sudo_if mkdir -p "$RBENV_ROOT/plugins"
    sudo_if chown -R "$USERNAME" "$RBENV_ROOT"
    # sudo_if ln -s /usr/local/share/ruby-build $RBENV_ROOT/plugins/ruby-build
fi

sudo_if git clone --depth=1 \
    -c core.eol=lf \
    -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    https://github.com/rbenv/ruby-build.git "$RBENV_ROOT/plugins/ruby-build"


# So instead of building into ${RBENV_ROOT}/versions/<version>, which is the default for `rbenv install <version>`,
# instead we must install into RUNNER_TOOL_CACHE/Ruby/<version>/x64 and symlink so rbenv continues to work as before.

# Create the directory if it doesn't exist.
sudo_if mkdir -p "$RBENV_ROOT/versions/$TOOLSET_VERSION/"

# Change the ownership of the directory to the current user.
sudo_if chown -R "$USERNAME" "$RBENV_ROOT/versions/$TOOLSET_VERSION/"

# Change the permissions to 755.
sudo_if chmod 755 "$RBENV_ROOT/versions/$TOOLSET_VERSION/"

# Create symbolic links.
sudo_if ln -s "$RUBY_VERSION_PATH/x64/*" "$RBENV_ROOT/versions/$TOOLSET_VERSION/"

# Success!
echo "Ruby has been installed successfully!"
