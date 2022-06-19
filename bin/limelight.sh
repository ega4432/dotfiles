#!/bin/bash -eu

echo "---> Setup limelight ..."
cd "$(dirname "$0")"

if [ ! -e /usr/local/bin/limelight ] || ! type limelight ; then
    git clone https://github.com/koekeishiya/limelight.git
    cd limelight
    make
    mv bin/limelight /usr/local/bin/limelight
    cd ../
    rm -rf limelight
    echo "Installed limelight successfully!"
else
    echo "Skipped installation of limelight because that is have been already installed."
fi
