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
)

echo "---> Linking basic dotfiles ..."
for item in "${home_files[@]}"; do
    ln -nfsv "$DOTFILES"/"$item" ~/."$item"
done

if cd "$DOTFILES"/zsh &> /dev/null ; then
    echo "---> Linking zsh files ..."
    find . -type f -name 'zsh*' | sed 's!^.*/!!' | xargs -I {} ln -nfsv $DOTFILES/zsh/{} ~/.{}
    cd ../bin
else
    echo "NG .... !"
    ls
fi

echo "---> Linking Brewfile ..."
ln -nfsv "${DOTFILES}"/Brewfile ~/.Brewfile

# Create .config directory
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

echo "--> Linking starship config ..."
ln -nfsv "$DOTFILES"/starship.toml ~/.config/starship.toml

echo "--> Linking yabai and skhd config ..."
if [ ! -d ~/.config/yabai ]; then
    mkdir ~/.config/yabai
fi

if [ ! -d ~/.config/skhd ]; then
    mkdir ~/.config/skhd
fi

ln -nfsv "$DOTFILES"/yabairc ~/.config/yabai/yabairc
ln -nfsv "$DOTFILES"/skhdrc ~/.config/skhd/skhdrc
