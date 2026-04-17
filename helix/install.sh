#!/usr/bin/env bash

set -e

BASE_URL="https://github.com/SymphonySimper/fork-helix"

pkg_dir=~/pkgs
bin_dir=~/.local/bin
cfg_dir=~/.configi/helix

# Ensure that needed dirs exist
mkdir -p ${pkg_dir}
mkdir -p ${bin_dir}

get_latest_ver() {
    curl -Ls -w %{url_effective} $BASE_URL/releases/latest | tail -n1 | sed 's|^.*/||'
}

download_helix() {
    [ -d "$pkg_dir/$dst_dir" ] && return

    if [ ! -f $pkg_dir/${pkg} ]; then
      if wget -S --spider "$URL" 2>&1 | grep -q 'HTTP/1.1 200 OK' ; then
        echo "Downloading helix pkg from github ($BASE_URL)"
        wget -q -P $pkg_dir $URL || die "Downloading pkg from gitlab had failed"
      else
        echo "Invalid URL: $URL"
        exit 1
      fi
    fi
}

setup_helix() {
    echo "Setting up helix"
    set -x
    cd ${pkg_dir}
    find ./ -type d -name 'helix-*' | head -n+2 | xargs rm -rf

    [ -d "${dst_dir}" ] || tar xf ${dst_dir}.tar.xz
    ls -rt helix-*.tar.xz | tail -n+3 | xargs rm -rf

    rm -rf helix; ln -s ${dst_dir} helix
    rm -rf ${bin_dir}/hx; ln -s ${pkg_dir}/helix/hx ${bin_dir}/hx
}

config_helix() {
  if [ -f "${cfg_dir}/config.toml" ]; then
    cd ${cfg_dir}/
    git pull --rebase origin main
  else
    git clone git@prem.github.com:hprem/helix_cfg.git ${cfg_dir}/
  fi
}

version=$1
[ -n "$version" ] || version=$(get_latest_ver)
dst_dir="helix-${version}-x86_64-linux"
pkg="${dst_dir}.tar.xz"
URL="${BASE_URL}/releases/download/${version}/${pkg}"

echo "Installing helix (version: $version)"
echo " -- pkg_dir: $pkg_dir, pkg: $pkg"
download_helix
setup_helix
config_helix
