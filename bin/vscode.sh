#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
    echo "invalid argument."
    exit 1
fi

OS="$1"

if [ "$OS" != "Darwin" ]; then
    echo "Stop the process because it supports macOS only ..."
    exit 0
fi

VSCODE_DOTFILES_DIR=~/src/github.com/ega4432/dotfiles/vscode
EXTENSIONS_FILE=extensions.txt
VSCODE_CONFIG_DIR=~/Library/Application\ Support/Code/User

echo "---> Setup extensions of Visual Studio Code ..."

if type code &> /dev/null && cd $VSCODE_DOTFILES_DIR &> /dev/null ; then
    echo "---> Installing extensions from $VSCODE_DOTFILES_DIR/$EXTENSIONS_FILE ..."

    while read -r line; do
        echo -n "."
        code --install-extension "${line}" --force >> ../log/vscode.log 2>&1
    done < $EXTENSIONS_FILE
    echo " Finished installation extensions successfully!"
else
    echo "Skipped installation of extensions because the \"code\" command not found."
fi

if [ -d "$VSCODE_CONFIG_DIR" ]; then
    echo "---> Linking config files of Visual Studio Code ..."
    vscode_files=("settings" "keybindings")
    for item in "${vscode_files[@]}"; do
        ln -nfsv "${VSCODE_DOTFILES_DIR}/${item}.json" "$VSCODE_CONFIG_DIR/${item}.json"
    done
else
    echo "Skipped linking because the \"$VSCODE_CONFIG_DIR\" directory not found."
fi
