#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
    echo "invalid argument."
    exit 1
fi

OS="$1"

cd "$(dirname "$0")"
echo "---> Setup Homebrew ..."

echo "---> Install the required tools ..."

if [ "$OS" == "Darwin" ]; then
    if ! xcode-select --print-path &>/dev/null; then
        echo "---> Installing command line tools ..."
        xcode-select --install
    fi
else
    apt-get update
    apt-get install build-essential procps curl file git
fi

if ! type brew &>/dev/null ; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Skipped installation of Homebrew CLI because the CLI has been already installed."
fi

if [ "${HOMEBREW_INSTALL_SKIP:-false}" != "true" ]; then
    STD_OUT=../log/brew_stdout.log
    STD_ERR=../log/brew_stderr.log

    exec 1> >(
        while read -r l; do echo "[$(date +"%Y-%m-%d %H:%M:%S")] $l"; done | tee -a $STD_OUT
    )
    exec 2> >(
        while read -r l; do echo "[$(date +"%Y-%m-%d %H:%M:%S")] $l"; done | tee -a $STD_ERR
    )

    brew bundle --file=../Brewfile --verbose
    echo "Homebrew Formulae and Casks have been installed successfully!"
else
    echo "Skip installation of Homebrew Formulae and Casks."
fi

if type yabai &>/dev/null && type skhd &>/dev/null ; then
    echo "Start background daemon of yabai and skhd."
    brew services restart yabai
    brew services restart skhd
fi
