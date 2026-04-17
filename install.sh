#!/usr/bin/env bash

die() { echo -e "$@"; exit 1; }

CWD="$(pwd)"

# Ensure ~/.config exists
mkdir ~/.config

# Create needed symlinks in ~/.config
for dir in nvim tmux; do
  ln -s "${CWD}/$dir" ~/.config/
done

# Install needed components
read -p 'Do you want to proceed with the installation of NeoVIM'
for dir in nvim; do
  ${CWD}/$dir/install.sh || die "Installation of $dir had failed"
done
