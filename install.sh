#!/bin/bash

mydir=$(cd $(dirname $0); pwd)

function config_link () {
  local name=$1; shift
  local src=${mydir}/config_${name}
  local dest=${HOME}/.config/${name}
  test -d ${HOME}/.config || mkdir ${HOME}/.config
  if [ -d ${dest} ]; then
    echo "Directory ${dest} exists, not removing"
    return
  fi
}

config_link kitty
