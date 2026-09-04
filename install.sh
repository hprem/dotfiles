#!/usr/bin/env bash

die() { echo -e "$@"; exit 1; }

CWD="$(pwd)"

# Ensure ~/.config exists
mkdir -p ~/.config

# Create needed symlinks in ~/.config
for dir in nvim tmux helix; do
  [ -e ~/.config/$dir ] && continue
  echo "Setting up dotfiles for $dir"
  ln -s "${CWD}/$dir" ~/.config/
done

# Create needed symlinks in ~/
for dir in zsh python; do
  echo "Setting up dotfiles for $dir"
  for fname in $(ls "${CWD}/$dir"); do
      [ -e ~/.$fname ] || ln -s "${CWD}/$dir/$fname" ~/.$fname
  done
done

# Install any external tools / repos
## Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Install needed components
## NeoVIM
read -p 'Do you want to proceed with the installation of NeoVIM' yn
case $yn in
  [Yy]*) ${CWD}/nvim/install.sh || die "Installation of NeoVIM had failed" ;;  
  [Nn]*) echo "Skipped" ;;
esac

## TMux
read -p 'Do you want to proceed with the installation of TMux' yn
case $yn in
  [Yy]*) ${CWD}/tmux/install.sh || die "Installation of TMux had failed" ;;  
  [Nn]*) echo "Skipped" ;;
esac
