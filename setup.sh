#!/usr/bin/env sh

##\file setup.sh
##\brief Install required build and documentation tools.
##
## This script installs all dependencies using apt, pip, and npm so that
## the documentation and build processes succeed. It provides Doxygen,
## Sphinx with the Breathe extension, CLOC, qemu utilities, and tmux.

set -e

## Install packages via apt if available.
install_apt() {
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update -y
        sudo apt-get install -y \
            build-essential \
            doxygen \
            python3-pip \
            cloc \
            qemu-system-x86 \
            qemu-utils \
            tmux \
            nodejs \
            npm
    fi
}

## Install Python packages using pip.
install_pip() {
    python3 -m pip install --user --upgrade \
        sphinx \
        breathe \
        sphinx-rtd-theme
}

## Install Node.js packages using npm.
install_npm() {
    npm install --global jsdoc
}

## Entry point for the setup script.
main() {
    install_apt
    install_pip
    install_npm
}

main "$@"
