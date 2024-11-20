#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
  echo "invalid argument."
  echo 1
fi

OS="$1"

if ! type asdf &>/dev/null; then
  if [ "$OS" == "Linux" ]; then
    echo "linux"
  else
    echo "mac"
  fi

  echo "\"asdf\" command not found."
  exit 1
fi

cd "$(dirname "$0")"

echo "---> Setup asdf ..."

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin-add python
