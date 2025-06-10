#!/usr/bin/env bash

##
# @file setup.sh
# @brief Provision a full development environment for illumos.
#
# This script installs all tools required to build, test and document the
# illumos tree on modern Linux distributions. It supersedes the old
# `rootsetup` helper by including those packages directly. The user must
# have sudo privileges.
##

set -euo pipefail

##
# @brief Refresh apt package metadata.
#
# The update step is executed once to ensure the latest versions are
# available before attempting any installation.
#
# @return void
##
apt_update() {
    sudo apt-get update -y
}

##
# @brief Select an appropriate tmux package.
#
# If the headless variant exists it is preferred as it avoids pulling in
# additional X11 dependencies.
#
# @return Selected package name
##
select_tmux() {
    if apt-cache show tmux-headless >/dev/null 2>&1; then
        echo "tmux-headless"
    else
        echo "tmux"
    fi
}

##
# @brief Install all apt based dependencies.
#
# Packages cover compilers, debugging utilities, documentation generators
# and emulators for both x86 and arm64 targets.
#
# @return void
##
install_apt_packages() {
    apt_update

    local tmux_pkg
    tmux_pkg="$(select_tmux)"

    local pkgs=(
        build-essential
        doxygen
        python3-sphinx
        python3-breathe
        python3-sphinx-rtd-theme
        cloc
        qemu-system-x86
        qemu-system-arm
        qemu-utils
        gcc-aarch64-linux-gnu
        clang
        clang-format
        clang-tidy
        gdb
        valgrind
        strace
        ltrace
        perf
        ccache
        cppcheck
        shellcheck
        git
        curl
        wget
    )

    if apt-cache show python3-sphinxcontrib >/dev/null 2>&1; then
        pkgs+=(python3-sphinxcontrib)
    fi

    pkgs+=("${tmux_pkg}")

    sudo apt-get install -y "${pkgs[@]}"
}

##
# @brief Install Python utilities via pip.
#
# These tools provide linting and formatting for the source tree.
#
# @return void
##
install_pip_packages() {
    local pip_pkgs=(ipython flake8 mypy black)
    python3 -m pip install --user --upgrade "${pip_pkgs[@]}"
}

##
# @brief Install Node.js tooling globally via npm.
#
# ESLint and Prettier aid JavaScript projects that accompany illumos.
#
# @return void
##
install_npm_packages() {
    local npm_pkgs=(eslint prettier)
    npm install --global "${npm_pkgs[@]}"
}

##
# @brief Output tool versions for verification.
#
# Helps confirm that the installed toolchain is accessible.
#
# @return void
##
report_versions() {
    clang --version
    python3 -m pip list | grep -E "(flake8|mypy|black)"
    eslint --version
    prettier --version
}

install_apt_packages
install_pip_packages
install_npm_packages
report_versions
