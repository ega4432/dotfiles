#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
    echo "invalid argument."
    exit 1
fi

OS="$1"

cd "$(dirname "$0")"
echo "---> Setup symbolic links ..."

DOTFILES=~/src/github.com/ega4432/dotfiles

home_files=(
    asdfrc
    bashrc
    bash_profile
    gitconfig
    gitconfig_global
    skhdrc
    tool-versions
    vimrc
    yabairc
)

echo "---> Linking basic dotfiles ..."
for item in "${home_files[@]}"; do
    ln -nfsv "$DOTFILES"/"$item" ~/."$item"
done

cd "$DOTFILES"/zsh

if [ "$OS" != "Darwin" ]; then
    echo "---> Install zsh ..."
    if apt-get install zsh &>/dev/null ; then
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
