#!/bin/bash -eu

cd "$(dirname "$0")"
echo "---> Setup symbolic links ..."

DOTFILES=~/src/github.com/ega4432/dotfiles

home_files=(
    bashrc
    bash_profile
    gitconfig
    gitconfig_global
    vimrc
    zshrc
)

echo "---> Linking basic dotfiles ..."
for item in "${home_files[@]}"; do
    ln -nfsv "${DOTFILES}"/"${item}" ~/."${item}"
done

echo "---> Linking Brewfile ..."
ln -nfsv "${DOTFILES}"/Brewfile ~/.Brewfile

echo "--> Linking starship config ..."
ln -nfsv "${DOTFILES}"/starship.toml ~/.config/starship.toml
