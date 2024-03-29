#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
    echo "invalid argument."
    exit 1
fi

OS="$1"

cd "$(dirname "$0")"
echo "---> Setup symbolic links ..."

DOTFILES=~/dotfiles

home_files=(
    asdfrc
    bashrc
    bash_profile
    gitconfig
    gitconfig_global
    tool-versions
    vimrc
)

echo "---> Linking basic dotfiles ..."
for item in "${home_files[@]}"; do
    ln -nfsv "$DOTFILES"/"$item" ~/."$item"
done

if ! cd "$DOTFILES"/zsh &>/dev/null ; then
    ls -ltra "$DOTFILES"
fi

if [ "$OS" != "Darwin" ]; then
    echo "---> Install zsh ..."
    sudo apt install -qq zsh
    if which zsh | tee -a /etc/shells &>/dev/null ; then
        chsh -s "$(which zsh)"
        echo "Updated login shell to \"zsh\" successfully!"
    fi
fi

echo "---> Linking zsh files ..."
find . -type f -name 'zsh*' | sed 's!^.*/!!' | xargs -I {} ln -nfsv $DOTFILES/zsh/{} ~/.{}

cd ../bin

echo "---> Linking Brewfile ..."
ln -nfsv "$DOTFILES"/Brewfile ~/.Brewfile

# Create .config directory
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

echo "--> Linking starship config ..."
ln -nfsv "$DOTFILES"/starship.toml ~/.config/starship.toml

echo "---> Linking GitHub CLI \"gh\" config files ..."

if [ ! -d ~/.config/gh ]; then
    mkdir ~/.config/gh
fi

ln -nfsv "$DOTFILES"/gh.yml ~/.config/gh/config.yml
