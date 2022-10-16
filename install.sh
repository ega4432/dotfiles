#!/usr/bin/env bash

set -eu

echo "Start setup..."

GIT_CLONE_DIR=~/src/github.com/ega4432
LOG_DIR="$GIT_CLONE_DIR/dotfiles/log"

# Requires super user priviledges
echo "$USER ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/"$USER"

if ! cd "$GIT_CLONE_DIR/dotfiles" &> /dev/null; then
    mkdir -p "$GIT_CLONE_DIR" && cd "$_"
    git clone https://github.com/ega4432/dotfiles.git
    cd dotfiles
fi

if [ ! -d $LOG_DIR ];then
    mkdir $LOG_DIR
fi

find bin/ -type f -name 'brew.sh' -exec bash {} \;
