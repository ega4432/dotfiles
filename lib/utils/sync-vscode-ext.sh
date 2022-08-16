#!/bin/bash -eu

if ! type code &> /dev/null; then
  echo "\"code\" command is not found"
  exit 1
fi

cd "$(dirname "$0")"

TARGET="./vscode/extensions.txt"
echo "Sync vscode extensions ..."

code --list-extensions > $TARGET

echo "Synced successfully to $TARGET"
