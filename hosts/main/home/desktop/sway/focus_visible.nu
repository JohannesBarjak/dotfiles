#!/usr/bin/env nu

# What to focus on.
let visible = swaymsg -t get_tree
    | jq '.. | select(.type?) | select(.visible==true) | .' # Select visible windows.
    | jq --slurp '.[0]'					    # Grab the first visible window.
    | from json;

swaymsg $"[con_id=($visible.id)] focus";
