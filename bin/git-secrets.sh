#!/bin/bash -ue

if ! git secrets &> /dev/null ; then
    echo "---> Installing \"git secrets\" command ..."
    brew install git-secrets
fi

echo "---> Setup git-secrets and installing hooks files ..."
# Set git-secret `[secret]` section into `~/.gitconfig`
git secrets --register-aws --global

# Download hooks file to `~/.git-templates/git-secrets`
git secrets --install ~/.git-templates/git-secrets
