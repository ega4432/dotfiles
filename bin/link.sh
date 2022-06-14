#!/bin/bash -eu

cd "$(dirname "$0")"
echo "---> Setup symbolic links ..."

DOTFILES="$HOME/src/github.com/ega4432/dotfiles"

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
    ln -nfsv "${DOTFILES}/${item}" "${HOME}/.${item}"
done

echo "---> Linking Brewfile ..."
ln -nfsv "${DOTFILES}/Brewfile" "${HOME}/Brewfile"
