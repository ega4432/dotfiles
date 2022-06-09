#!/bin/bash -eu

echo "---> Linking basic dotfiles ..."

if [ -z "$DOTFILES" ]; then
    export DOTFILES="$HOME/src/github.com/ega4432/dotfiles"
fi

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
