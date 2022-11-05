#!/usr/bin/env bash

set -ue

cd "$(dirname "$0")"
echo "---> Setup git-secrets ..."

GIT_CLONE_DIR=~/src/github.com/ega4432

if ! type git &>/dev/null ; then
    echo "\"git\" command not found."
    exit 1
fi

if ! git secrets &>/dev/null ; then
    echo "---> Installing \"git-secrets\" command ..."

    if ! cd "$GIT_CLONE_DIR" &>/dev/null; then
        mkdir -p "$GIT_CLONE_DIR" && cd "$_"
    fi

    git clone https://github.com/awslabs/git-secrets.git
    cd git-secrets
    sudo make install
    echo "\"git-secrets\" command has been installed successfully! "
fi

echo "---> Setup git-secrets and installing hooks files ..."
# Set git-secret `[secret]` section into `~/.gitconfig`
git secrets --register-aws --global

# Download hooks file to `~/.git-templates/git-secrets`
# git secrets --install ~/.git-templates/git-secrets
