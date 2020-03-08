#!/usr/bin/env bash

set -u

# Try to download binary executable
archi=$(uname -sm)
binary_available=1
binary_error=""
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
  CYGWIN*\ *64)    echo windows-amd64 ;;
  MINGW*\ *86)     echo windows-386   ;;
  MINGW*\ *64)     echo windows-amd64 ;;
  MSYS*\ *86)      echo windows-386   ;;
  MSYS*\ *64)      echo windows-amd64 ;;
  Windows*\ *86)   echo windows-386   ;;
  Windows*\ *64)   echo windows-amd64 ;;
  *)               ;;
esac
