# NeoVIM

### Install neovim
```bash
mkdir -p ~/.local ~/.pkgs; cd ~/.pkgs

wget https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz
rm -rf nvim-linux-x86_64.tar.gz
ln -s nvim-linux-x86_64 nvim
ln -s ~/.pkgs/nvim/bin/nvim ~/.local/bin/nvim
```

### Install plug.vim
```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
         --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim --headless +'PlugInstall' +qall
```
