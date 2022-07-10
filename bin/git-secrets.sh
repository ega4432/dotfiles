#!/bin/bash -ue

cd "$(dirname "$0")"
echo "---> Setup git-secrets ..."

if ! git secrets &> /dev/null ; then
    GIT_CLONE_DIR=~/src/github.com/ega4432
    echo "---> Installing \"git-secrets\" command ..."
    cd $GIT_CLONE_DIR
    git clone https://github.com/awslabs/git-secrets.git
    cd git-secrets
    make install
    echo -n "\"git-secrets\" command has been installed successfully! "
fi

echo "---> Setup git-secrets and installing hooks files ..."
# Set git-secret `[secret]` section into `~/.gitconfig`
git secrets --register-aws --global

# Download hooks file to `~/.git-templates/git-secrets`
git secrets --install ~/.git-templates/git-secrets
