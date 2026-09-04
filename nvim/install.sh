#!/usr/bin/env bash

#
# Usage: install.sh [<version>]
#

# Util functions
die() {
  echo -e "$@"
  exit 1
}
get_latest_ver() {
  curl -Ls -w "%{url_effective}" "$1/releases/latest" | tail -n1 | sed 's|^.*/||'
}

# Cli Args
version=$1

# Create needed directories
mkdir -p ~/.local/bin ~/.config/nvim ~/.pkgs

pushd ~/.pkgs > /dev/null || die "Cannot cd to ~/.pkgs"

# Download latest nvim pkg
REPO="https://github.com/neovim/neovim/"
[ -n "$version" ] || version="$(get_latest_ver $REPO)"
wget "${REPO}releases/download/${version}/nvim-linux-x86_64.tar.gz" || die "Downloading neovim $version had failed"

# Remove old nvim installations except the last one
find ./ -type d -name 'nvim-linux-x86_64-*' | head -n+1 | xargs rm -rf

# Extract it and remove the tar.gz file
tar xf nvim-linux-x86_64.tar.gz
rm -rf nvim-linux-x86_64.tar.gz

# Create needed synlinks
ln -s nvim-linux-x86_64 nvim
ln -s ~/.pkgs/nvim/bin/nvim ~/.local/bin/nvim

# Install tree-sitter
REPO="https://github.com/tree-sitter/tree-sitter"
version="$(get_latest_ver $REPO)"i
mkdir ~/.local/bin
wget -O - https://github.com/tree-sitter/tree-sitter/releases/download/${version}/tree-sitter-linux-x64.gz | gunzip -c > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter

# Launch neovim once to install nvim plugins
nvim --headless +'PlugInstall' +qall

echo "NeoVim setup is complete"
echo "Make sure ~/.local/bin/ is in $PATH"
