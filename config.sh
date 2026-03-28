#!/bin/bash

set -e

VM_NAME="WorkspaceVm"
DISK_NAME="$VM_NAME.qcow2"
DISK_SIZE="200G"

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
TEMPLATE_DIR="$SCRIPT_DIR/template"
SHARED_DIR_PATH="$HOME/projects/Vmdirs"

GITHUB_RELEASE_URL="https://github.com/Sqydev/Virtspace/releases/download/1.0.0v/TemplateVM.qcow2.gz"

RAM=2048 # MB
CPU=2 # cores

TEMPLATE_GZ="$TEMPLATE_DIR/TemplateVM.qcow2.gz"
TEMPLATE_PATH="$TEMPLATE_DIR/TemplateVM.qcow2"

TARGET_PATH="$HOME/Virtspace/$DISK_NAME"
