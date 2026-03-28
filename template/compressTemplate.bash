#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../config.sh"

if [ ! -f "$TEMPLATE_PATH" ]; then
    echo "Template QCOW2 not found at $TEMPLATE_PATH"
    exit 1
fi

echo "Compressing template..."
gzip -c "$TEMPLATE_PATH" > "$TEMPLATE_GZ"

echo "Template compressed to $TEMPLATE_GZ"
