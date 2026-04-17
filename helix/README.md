# Helix

### What is Helix

[Helix](https://github.com/helix-editor/helix) is a vim-like editor,
but a lot more beginner friendly. I've been using neovim for a long
time, but was getting tired of managing its plugins.

Give it a try and you might like it

### Install
```bash
# Use helix's fork for access to latest weekly build
REPO="https://github.com/SymphonySimper/fork-helix"
get_latest_ver() { curl -Ls -w "%{url_effective}" "$1/releases/latest" | tail -n1 | sed 's|^.*/||'; }

version=$(get_latest_ver "$REPO")
wget -q -P ~/.pkgs/ ${BASE_URL}/releases/${version}/helix-${version}-x86_64-linux.tar.xz"

cd ~/.pkgs
tar xf helix-*-x86_64-linux.tar.xz; rm -rf helix-*-x86_64-linux.tar.xz
ln -s helix-*-x86_64 helix
ln -s $(pwd)/helix/hx ~/.local/bin/
```

### Install bash lsp
```bash
# Install shellcheck
mkdir -p ~/.pkgs
wget -qO- "https://github.com/koalaman/shellcheck/releases/download/latest/shellcheck-latest.linux.x86_64.tar.xz" | tar --strip-components 1 --wildcards -C ~/pkgs/ -xJv '**/shellcheck'
ln -s ~/pkgs/shellcheck ~/.local/bin

# Install shfmt - shell formatter
wget https://github.com/mvdan/sh/releases/download/v3.12.0/shfmt_v3.12.0_linux_amd64
chmod +x shfmt_v3.12.0_linux_amd64
ln -s ~/.pkgs/shfmt_v3.12.0_linux_amd64  ~/.local/bin/shfmt

# Bash lsp
# TODO: check if there is a better way to install it without snap
sudo snap install bash-language-server --classic
```

### Install python lsp
```bash
```
