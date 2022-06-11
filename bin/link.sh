#!/bin/bash -eu

echo "---> Linking basic dotfiles ..."

DOTFILES="$HOME/src/github.com/ega4432/dotfiles"

home_files=(
    bashrc
    bash_profile
    gitconfig
    gitconfig_global
    vimrc
    zshrc
)

for item in "${home_files[@]}"; do
    ln -nfsv "${DOTFILES}/${item}" "${HOME}/.${item}"
done

echo "---> Linking Brewfile ..."
ln -nfsv "${DOTFILES}/Brewfile" "${HOME}/Brewfile"
