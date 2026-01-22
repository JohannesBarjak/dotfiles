# Enable and configure rofi.
{config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    theme = (import ./theme.nix { inherit config; });
    font = "Cousine Nerd Font Propo";

    # Add calculator plugin to rofi.
    plugins = [
      pkgs.rofi-calc
    ];

    modes = [ "drun" "window" "combi" ];

    extraConfig = {
      show-icons = true;

      # Change modi default text to icons.
      display-drun = "󰀻 ";
      display-window = "";

      combi-modes = [ "drun" "window" ];

      # Prefer fuzzy searching.
      sort = true;
      sorting-method = "fzf";
      matching = "fuzzy";
    };
  };
}
