#!/bin/bash

set -e

source "$(dirname "$(realpath "$0")")/config.sh"

mkdir -p "$TEMPLATE_DIR"
mkdir -p "$(dirname "$TARGET_PATH")"
mkdir -p "$SHARED_DIR_PATH"

if [ ! -f "$TEMPLATE_GZ" ]; then
    echo "Downloading template from GitHub Releases..."
    wget -O "$TEMPLATE_GZ" "$GITHUB_RELEASE_URL"
fi

if [ ! -f "$TARGET_PATH" ]; then
    echo "Creating VM from template..."
    gzip -dc "$TEMPLATE_GZ" > "$TARGET_PATH"
    echo "VM created at $TARGET_PATH"
fi

echo "VM ready. Root password is 'root'"
