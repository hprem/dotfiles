# NeoVIM

### Install neovim
```bash
set -euo pipefail


repo="neovim/neovim"
ver="$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name')"

mkdir -p ~/.local ~/.pkgs; cd ~/.pkgs
wget https://github.com/neovim/neovim/releases/download/$ver/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz
rm -rf nvim-linux-x86_64.tar.gz
ln -s nvim-linux-x86_64 nvim
ln -s ~/.pkgs/nvim/bin/nvim ~/.local/bin/nvim

# Launch neovim to make sure all needed plugins are installed
nvim --headless +qall
```
