#!/bin/bash -eu

echo "Start setup ..."

if ! cd $HOME/src/github.com/ega4432/dotfiles &> /dev/null ; then
    mkdir -p $HOME/src/github.com/ega4432 && cd $_
    git clone https://github.com/ega4432/dotfiles.git dotfiles
    cd dotfiles
fi

find ./bin -type f -name '*.sh' | xargs -p -I {} bash -c {}
