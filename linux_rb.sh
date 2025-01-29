#!/usr/bin/env bash
nix fmt
# zsh linux_clear.sh
nixos-rebuild switch --use-remote-sudo --flake .#default
