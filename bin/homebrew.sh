#!/bin/bash -eu

echo "Setup homebrew ..."

if [ "$(uname)" == "Darwin" -o "$(uname)" == "Linux" ]; then
    if ! type brew &> /dev/null ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &> /dev/null
    else
        echo "Homebrew is already installed."
    fi
fi

if [ "$(ENV)" != "ci" ]; then
    brew bundle install --file=../Brewfile
fi
