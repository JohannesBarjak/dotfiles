# Enable and configure rofi.
{config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    theme = (import ./gruvbox.nix { inherit config; });
    font = "Cousine Nerd Font Propo";

    # Add calculator plugin to rofi.
    plugins = [ pkgs.rofi-calc ];

    extraConfig = {
      show-icons = true;
      display-drun = "󰣖 drun:";

      sort = true;
      sorting-method = "fzf";
      matching = "fuzzy";
    };
  };
}
