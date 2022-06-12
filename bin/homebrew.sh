#!/bin/bash -eu

cd "$(dirname "$0")"
echo "---> Setup homebrew..."

if [ "$(uname)" == "Darwin" ] || [ "$(uname)" == "Linux" ]; then
    if ! type brew &> /dev/null ; then
        sudo /bin/bash -c "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
    else
        echo "Homebrew is already installed."
    fi
fi

if [ "$ENV" != "ci" ]; then
    brew bundle install --file=../Brewfile
    echo "Homebrew Formulae and Casks have been installed successfully!"
else
    echo "Skip installation of Homebrew Formulae and Casks..."
fi
