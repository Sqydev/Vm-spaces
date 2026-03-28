#!/bin/bash
set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../config.sh"

TEMPLATE_DIR="$SCRIPT_DIR"
mkdir -p "$TEMPLATE_DIR"
mkdir -p "$SHARED_DIR_PATH"

TEMPLATE_GZ="$TEMPLATE_DIR/TemplateVM.qcow2.gz"
TEMPLATE_PATH="$TEMPLATE_DIR/TemplateVM.qcow2"

echo "Root password is 'root'"

if [ ! -f "$TEMPLATE_PATH" ]; then
    if [ ! -f "$TEMPLATE_GZ" ]; then
        echo "Downloading template from GitHub Releases..."
        wget -O "$TEMPLATE_GZ" "$GITHUB_RELEASE_URL"
    fi
    echo "Unpacking template..."
    gzip -dc "$TEMPLATE_GZ" > "$TEMPLATE_PATH"
fi

qemu-system-x86_64 \
    -name TemplateVM \
    -m $RAM -smp $CPU \
    -drive file="$TEMPLATE_PATH",format=qcow2 \
    -boot c \
    -netdev user,id=net0 -device e1000,netdev=net0 \
    -enable-kvm \
    -nographic -serial mon:stdio \
    -virtfs local,path="$SHARED_DIR_PATH",mount_tag=shared0,security_model=mapped,id=shared0
