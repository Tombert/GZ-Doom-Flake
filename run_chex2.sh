#!/bin/sh
unset LD_PRELOAD
export STEAM_RUNTIME=1
unset LD_LIBRARY_PATH
nix run .#chex2
