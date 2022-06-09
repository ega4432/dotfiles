#!/bin/bash -eu

echo -e "Start setup ...\n"

if [ -z "$DOTFILES" ]; then
    export DOTFILES="$HOME/src/github.com/ega4432/dotfiles"
fi

if ! cd $DOTFILES &> /dev/null ; then
    mkdir -p $DOTFILES && cd $_
    git clone https://github.com/ega4432/dotfiles.git dotfiles
    cd dotfiles
    echo;
fi

find ./bin -type f -name '*.sh' | xargs -p -I {} bash -c {}
