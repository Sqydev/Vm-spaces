#!/bin/bash

set -e

source "$(dirname "$(realpath "$0")")/config.sh"

if [ ! -f "$TARGET_PATH" ]; then
    echo "VM disk not found at $TARGET_PATH. Run createVm.bash first."
    exit 1
fi

USB_ARGS=""
for usb in $(lsusb | awk '{print $6}'); do
    VID=$(echo $usb | cut -d: -f1)
    PID=$(echo $usb | cut -d: -f2)
    USB_ARGS="$USB_ARGS -device usb-host,vendorid=0x$VID,productid=0x$PID"
done

qemu-system-x86_64 \
    -name "$VM_NAME" \
    -m $RAM -smp $CPU \
    -drive file="$TARGET_PATH",format=qcow2 \
    -boot order=c \
    -netdev user,id=net0 -device e1000,netdev=net0 \
    -enable-kvm \
    -usb $USB_ARGS \
    -nographic -serial mon:stdio \
    -virtfs local,path="$SHARED_DIR_PATH",mount_tag=shared0,security_model=mapped,id=shared0
