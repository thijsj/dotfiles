#!/bin/bash

mydir=$(cd $(dirname $0); pwd)
config_dir=${HOME}/.config

function _link () {
  local name=$1; shift
  local src=$1; shift
  local dest=$1; shift
  if [ -L ${dest} ]; then
    if [ "$(readlink ${dest})" == "${src}" ]; then
      echo "'${name}' is already configured"
      return
    fi
  fi
  ln -snf ${src} ${dest}
  echo "Configured '${name}'"
}
function config_link () {
  local name=$1; shift
  local src=${mydir}/config_${name}
  local dest=${config_dir}/${name}
  test -d ${HOME}/.config || mkdir ${HOME}/.config
  if [ -d ${dest} ] && [ ! -L ${dest} ]; then
    echo "Directory ${dest} exists, not removing"
    return
  fi
  _link "${name}" "${src}" "${dest}"
}

function dot_link () {
  local name=$1; shift
  local src=${mydir}/${name}
  local dest=${HOME}/.${name}
  _link "${name}" "${src}" "${dest}"
}

config_link kitty
dot_link vimrc
