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

# Findder
chflags nohidden ~/Library # Show Library folder
defaults write com.apple.finder AppleShowAllFiles YES # Show hidden files
defaults write com.apple.finder ShowPathbar -bool true # Show path bar
defaults write com.apple.finder ShowStatusBar -bool true # Show status bar
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
killall Finder

# Dock
defaults write com.apple.dock tilesize -int 15
defaults write com.apple.dock largesize -int 70
defaults write com.apple.dock show-recents -bool "false"
killall Dock



