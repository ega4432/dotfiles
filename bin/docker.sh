#!/usr/bin/env bash

set -ue

echo "---> Install docker ..."

case $(uname -s) in
    Darwin)
        echo "Please download \"Docker Desktop\" from here."
        echo "https://docs.docker.com/desktop/install/mac-install/"
        exit 0
        ;;
    Linux)
        # Ref. https://docs.docker.com/engine/install/ubuntu/

        if type docker &>/dev/null ; then
            echo "\docker\" already exists,"
            type docker
            exit 0
        fi

        echo "---> Installing dependencies ..."
        sudo apt-get -qq update
        sudo apt-get install -qq ca-certificates curl gnupg

        echo "---> Add official GPG key ..."
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg

        echo "---> Setup repository ..."
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        echo "---> Installing docker engine ..."
        sudo apt -qq update
        sudo apt-get install -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        echo "---> Add current user to docker group ..."
        if ! grep docker /etc/group &>/dev/null ; then
            sudo groupadd docker
        fi
        sudo gpasswd -a "$USER" docker
        echo "Successfully installed docker!"
        ;;
esac
