#!/usr/bin/env bash

set -eu

echo "---> Setup VSCode ..."

VSCODE_DOTFILES_DIR=~/dotfiles/vscode
EXTENSIONS_FILE=extensions.txt
VSCODE_CONFIG_DIR=~/Library/Application\ Support/Code/User

echo "---> Setup extensions of Visual Studio Code ..."

if ! type code &> /dev/null ; then
    echo "---> Installing Visual Studio Code ..."

    case $(uname -s) in
        Darwin)
            brew install --cask visual-studio-code

            if [ -d "$VSCODE_CONFIG_DIR" ]; then
                echo "---> Linking config files of Visual Studio Code ..."
                vscode_files=("settings" "keybindings")
                for item in "${vscode_files[@]}"; do
                    ln -nfsv "${VSCODE_DOTFILES_DIR}/${item}.json" "$VSCODE_CONFIG_DIR/${item}.json"
                done
            else
                echo "Skipped linking because the \"$VSCODE_CONFIG_DIR\" directory not found."
            fi

            ;;
        Linux)
            wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

            sudo apt update
            sudo apt install -qq code
            ;;
        *)
            echo "Skipped installation of Visual Studio Code because the OS is not supported."
            uname -a
            exit 0
            ;;
    esac

else
    echo "Skipped installation of Visual Studio Code because the \"code\" command has been already installed."
fi

if type code &> /dev/null && cd $VSCODE_DOTFILES_DIR &> /dev/null ; then
    echo "---> Installing extensions from $VSCODE_DOTFILES_DIR/$EXTENSIONS_FILE ..."

    if [ -d ../log ]; then
        mkdir ../log
    fi

    while read -r line; do
        echo -n "."
        code --install-extension "${line}" --force >> ../log/vscode.log 2>&1
    done < $EXTENSIONS_FILE
    echo " Finished installation extensions successfully!"
else
    echo "Skipped installation of extensions because the \"code\" command not found."
fi
