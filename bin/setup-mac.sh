#!/usr/bin/env bash

set -eu

if [ $# != 1 ]; then
    echo "invalid argument."
    exit 1
fi

OS="$1"

echo "---> Setup macOS settings ..."

if [ "$OS" != "Darwin" ]; then
    echo "Skipped this process because it's not the target OS($OS)"
    exit 0
fi

# Show Library folder
chflags nohidden ~/Library

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

killall Finder
