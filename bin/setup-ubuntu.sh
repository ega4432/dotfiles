#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
    echo "invalid argument."
    exit 1
fi

OS="$1"

echo "---> Setup Ubuntu settings ..."

if [ "$OS" != "Linux" ]; then
    echo "Skipped this process because it's not the target OS($OS)"
    exit 0
fi

packages=(
    jq
    tree
    speedtest-cli
    vim
)

sudo apt install -qq "${packages[@]}"
