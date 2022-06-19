#!/bin/bash -eu

cd "$(dirname "$0")"
echo "---> Setup Homebrew ..."

if [ "$(uname)" == "Darwin" ] || [ "$(uname)" == "Linux" ]; then
    if ! type brew &> /dev/null ; then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Skipped installation of Homebrew CLI because the CLI has been already installed."
    fi
fi

if [ "$HOMEBREW_INSTALL_SKIP" != "true" ]; then
    brew bundle --file=../Brewfile 1>> ../log/brew_stdout.log 2>> ../log/brew_stderr.log
    echo "Homebrew Formulae and Casks have been installed successfully!"
else
    echo "Skip installation of Homebrew Formulae and Casks."
fi

if type yabai &> /dev/null && type skhd &> /dev/null ; then
    echo "Start background daemon of yabai and skhd."
    brew services restart yabai
    brew services restart skhd
fi
