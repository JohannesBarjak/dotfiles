# Enable and configure rofi.
{...}: {
  modules.rofi.home = {config, pkgs, ...}: {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;

      theme = config.rofi.theme;
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
  };
}
