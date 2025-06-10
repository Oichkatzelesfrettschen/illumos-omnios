#!/usr/bin/env bash

##
# @file setup.sh
# @brief Install a comprehensive development toolkit.
#
# This front-end script installs packages for building, analysis, linting,
# debugging and profiling illumos.  It invokes `./rootsetup` to gather
# documentation-related tools and then installs additional utilities from
# apt, pip and npm.  Users must have sudo privileges.
##

set -euo pipefail

# First acquire the basic documentation toolchain.
./rootsetup

# Base apt packages for development and analysis.
APT_PKGS="clang clang-format clang-tidy gdb valgrind strace ltrace perf
          ccache cppcheck shellcheck git curl wget"

# Install the apt packages in one shot.
sudo apt-get install -y "$APT_PKGS"

# Install helpful Python tools using pip.
PIP_PKGS="ipython flake8 mypy black"
python3 -m pip install --user --upgrade "$PIP_PKGS"

# Global npm utilities for JavaScript linting and formatting.
NPM_PKGS="eslint prettier"
npm install --global "$NPM_PKGS"

# Report versions for verification.
clang --version
python3 -m pip list | grep -E "(flake8|mypy|black)"
eslint --version
prettier --version

