#!/bin/bash

set -e

VERSION=1.0.1

install()
{
    echo "Stem is being download ..."

    # check Linux, MacOS or other
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    echo "Machine detection says ${machine}"

    if [ "$machine" == "Mac" ]; then
        BUNDLE=stem-binaries-bundle-${VERSION}-MacOS.tgz
    elif [ "$machine" == "Linux" ]; then
        BUNDLE=stem-binaries-bundle-${VERSION}-Linux.tgz
    else
        BUNDLE=stem-binaries-bundle-${VERSION}-Linux.tgz
    fi

    # check if file exists
    rm -f ${BUNDLE}

    wget "https://github.com/anmaped/stem-binaries/releases/download/v1.0.x/${BUNDLE}"

    echo "stem will be installed in home directory ('~/stem-binaries') ..."
    mkdir -p ~/stem-binaries
    tar -xf ${BUNDLE} -C ~/stem-binaries

    # check that stem is running well
    cd ~/stem-binaries && ./stem --version

    echo "stem tool has been installed successfully."

}

while true; do
    read -p "Welcome to stem bundle installation. Press Y to continnue. " yn
    case $yn in
        [Yy]* ) install; break;;
        [Nn]* ) exit;;
        * ) echo "Press Y or n.";;
    esac
done