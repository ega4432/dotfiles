#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
    echo "invalid argument."
    exit 1
fi

OS="$1"

cd "$(dirname "$0")"
echo "---> Setup Homebrew ..."

echo "---> Installing the required tools ..."

if [ "$OS" == "Linux" ]; then
    sudo apt-get update
    sudo apt-get install -y build-essential procps curl file git
fi

if ! type brew &>/dev/null ; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ "$OS" == "Linux" ]; then
        test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
      if [ "$(uname -m)" == "arm64" ]; then
        # for M1 Mac
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
      else
        # for intel Mac
        echo 'alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin brew"' >> ~/.zsh_alias
      fi
    fi
else
    echo "Skipped installation of Homebrew CLI because the CLI has been already installed."
fi

if [ "${HOMEBREW_INSTALL_SKIP:-false}" != "true" ]; then
    test -d ../log || mkdir ../log

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
