#!/bin/bash -eu

cd "$(dirname "$0")"
echo "---> Setup symbolic links ..."

DOTFILES=~/src/github.com/ega4432/dotfiles

home_files=(
    bashrc
    bash_profile
    gitconfig
    gitconfig_global
    skhdrc
    vimrc
    yabairc
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

echo "--> Linking limelight config ..."

if [ ! -d ~/.config/limelight ]; then
    mkdir -p ~/.config/limelight
fi

ln -nfsv "$DOTFILES"/limelightrc ~/.config/limelight/limelightrc
