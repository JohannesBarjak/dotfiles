# Enable and configure rofi.
{config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./gruvbox-material.rasi;

    extraConfig = {
      show-icons = true;
    };
  };
}
