#!/usr/bin/env nu

def main [] {
    cd ~/.dotfiles
    nix flake update
    git add flake.lock
    git commit -m "Update lockfile."
}
