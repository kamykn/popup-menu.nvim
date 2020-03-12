#!/usr/bin/env bash

set -u

# Echo binary path executable to stdout.
# FYI:
# https://github.com/kamykn/popup-menu.nvim/pull/1/files
# https://github.com/junegunn/fzf/blob/7c40a424c0bf5a8967816d51ead6a71a334f30bb/install#L176-L202
# https://github.com/golang/go/wiki/GoArm
archi=$(uname -sm)
case "$archi" in
  Darwin\ *64)     echo darwin-amd64  ;;
  Darwin\ *86)     echo darwin-386    ;;
  Linux\ armv5*)   echo linux-arm5    ;;
  Linux\ armv6*)   echo linux-arm6    ;;
  Linux\ armv7*)   echo linux-arm7    ;;
  Linux\ armv8*)   echo linux-amd64   ;;
  Linux\ aarch64*) echo linux-amd64   ;;
  Linux\ *64)      echo linux-amd64   ;;
  Linux\ *86)      echo linux-386     ;;
  FreeBSD\ *64)    echo freebsd-amd64 ;;
  FreeBSD\ *86)    echo freebsd-386   ;;
  OpenBSD\ *64)    echo openbsd-amd64 ;;
  OpenBSD\ *86)    echo openbsd-386   ;;
  CYGWIN*\ *64)    echo win-amd64 ;;
  MINGW*\ *86)     echo win-386   ;;
  MINGW*\ *64)     echo win-amd64 ;;
  MSYS*\ *86)      echo win-386   ;;
  MSYS*\ *64)      echo win-amd64 ;;
  Windows*\ *86)   echo win-386   ;;
  Windows*\ *64)   echo win-amd64 ;;
  *)               ;;
esac
