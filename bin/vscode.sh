#!/bin/bash -eu

VSCODE_DOTFILES_DIR=~/src/github.com/ega4432/dotfiles/vscode
EXTENSIONS_FILE=extensions.txt
VSCODE_CONFIG_DIR=~/Library/Application\ Support/Code/User

echo "---> Setup extensions of Visual Studio Code ..."

if type code &> /dev/null && cd $VSCODE_DOTFILES_DIR &> /dev/null ; then
    echo "---> Installing extensions from $VSCODE_DOTFILES_DIR/$EXTENSIONS_FILE ..."

    while read -r line; do
        code --install-extension "${line}"
    done < $EXTENSIONS_FILE
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
