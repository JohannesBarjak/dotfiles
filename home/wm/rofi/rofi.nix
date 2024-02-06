# Enable and configure rofi.
{config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = (import ./gruvbox.nix { inherit config; });

    extraConfig = {
      show-icons = true;
      display-drun = "󰣖 drun:";
    };
  };
}
