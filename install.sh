#!/bin/bash

mydir=$(cd $(dirname $0); pwd)

function config_link () {
  local name=$1; shift
  local src=${mydir}/config_${name}
  local dest=${HOME}/.config/${name}
  test -d ${HOME}/.config || mkdir ${HOME}/.config
  if [ -d ${dest} ] && [ ! -L ${dest} ]; then
    echo "Directory ${dest} exists, not removing"
    return
  fi
  if [ -L ${dest} ]; then
    if [ "$(readlink ${dest})" == "${src}" ]; then
      echo "'${name}' is already configured"
      return
    fi
  fi
  ln -snf ${src} ${dest}
  echo "Configured '${name}'"
}

config_link kitty
