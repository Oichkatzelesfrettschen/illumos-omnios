#!/bin/sh
set -e
# Install build dependencies
sudo apt-get update -y
sudo apt-get install -y \
    doxygen \
    python3-sphinx \
    python3-sphinx-rtd-theme \
    python3-breathe \
    python3-dev \
    cloc \
    qemu-system-x86 \
    qemu-utils \
    tmux \
    clang-format
