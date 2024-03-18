# Enable and configure rofi.
{config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    theme = (import ./gruvbox.nix { inherit config; });
    font = "Fira Code Medium 12";

    extraConfig = {
      show-icons = true;
      display-drun = "󰣖 drun:";
    };
  };
}
