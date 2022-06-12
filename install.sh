#!/bin/bash -eu

echo "Start setup..."

GIT_CLONE_DIR="$HOME/src/github.com/ega4432"

if ! xcode-select --print-path &> /dev/null; then
    echo "---> Installing command line tools ..."
    xcode-select --install
fi

if ! cd "$GIT_CLONE_DIR/dotfiles" &> /dev/null; then
    mkdir -p "$GIT_CLONE_DIR" && cd "$_"
    git clone https://github.com/ega4432/dotfiles.git
    cd dotfiles
fi

find bin/ -type f -name '*.sh' -print0 | xargs -I {} bash -c {}
