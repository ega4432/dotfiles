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

echo "---> Linking zsh files ..."
find . -type f -name 'zsh*' | sed 's!^.*/!!' | xargs -I {} ln -nfsv $DOTFILES/zsh/{} ~/.{}

cd ../bin

echo "---> Linking Brewfile ..."
ln -nfsv "$DOTFILES"/Brewfile ~/.Brewfile

# Create .config directory
mkdir -p ~/.config

echo "--> Linking starship config ..."
ln -nfsv "$DOTFILES"/starship.toml ~/.config/starship.toml

echo "---> Linking GitHub CLI \"gh\" config files ..."

mkdir -p ~/.config/gh

ln -nfsv "$DOTFILES"/gh.yml ~/.config/gh/config.yml

mkdir -p ~/.config/ghostty
if [ -f ~/.config/ghostty/config ]; then
  rm -f ~/.config/ghostty/config
fi

ln -nfsv "$DOTFILES"/ghostty_config ~/.config/ghostty/config

echo "---> Linking herdr config ..."

if [ ! -d ~/.config/herdr ]; then
    mkdir ~/.config/herdr
fi

ln -nfsv "$DOTFILES"/herdr.toml ~/.config/herdr/config.toml

