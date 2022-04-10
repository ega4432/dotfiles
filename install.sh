#!/bin/bash -eux

echo "Start setup ..."

if [ $(uname) = Darwin ]; then
    if ! type brew &> /dev/null ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Since Homebrew is already installed, skip this phase and proceed."
    fi
    brew update
    brew upgrade
    brew cleanup
    brew bundle install --file=Brewfile
else
    echo $uname
fi
