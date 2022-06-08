#!/bin/bash -eux

echo "Start setup ..."

if ! cd $HOME/dotfiles &> /dev/null ; then
    git clone https://github.com/ega4432/dotfiles.git $HOME/dotfiles
    cd $HOME/dotfiles
fi

if [ "$(uname)" = "Darwin" ]; then
    if ! type brew &> /dev/null ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
    else
        echo "Since Homebrew is already installed, skip this phase and proceed."
    fi
    echo "install dependecies ..."
    # brew update
    # brew upgrade
    # brew cleanup
    # brew bundle install --file=Brewfile
else
    echo -n "Not macOS ..."
    echo $uname
fi
