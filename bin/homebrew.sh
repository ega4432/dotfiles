#!/bin/bash -eu

cd "$(dirname "$0")"
echo -e "Setup homebrew ...\n"

if [ "$(uname)" == "Darwin" -o "$(uname)" == "Linux" ]; then
    if ! type brew &> /dev/null ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &> /dev/null
    else
        echo -e "Homebrew is already installed.\n"
    fi
fi

if [ "$ENV" != "ci" ]; then
    brew bundle install --file=../Brewfile
else
    echo -e "Skip in CI."
fi
