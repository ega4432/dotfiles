#!/usr/bin/env bash

set -eu

echo "Start setup..."

OS=""

if [ "$(uname -s)" == "Darwin" ]; then
    OS="Darwin"
elif [ "$(uname -s | cut -c 1-5)" == "Linux" ]; then
    OS="Linux"
else
    echo "Your platform ($(uanme -s)) is not supported."
    uname -a
    exit 1
fi

# Requires super user priviledges
echo "$USER ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/"$USER"

if [ "$OS" == "Linux" ]; then
    sudo apt install -qq curl git
fi

if ! cd "$HOME/dotfiles" &>/dev/null; then
    git clone https://github.com/ega4432/dotfiles.git "$HOME/dotfiles"
    cd "$HOME/dotfiles"
fi

if [ ! -d log ];then
    mkdir log
fi

echo "=== target OS: $OS === "

find bin/ -type f -name '*.sh' -exec bash {} "$OS" \;
