{config, ...}: {
  imports = [ ./wallpapers ];

  wayland.windowManager.sway = {
    enable = true;

    config = {
      menu = "${config.programs.rofi.package}/bin/rofi -show drun";
      terminal = "${config.programs.kitty.package}/bin/kitty --single-instance";
      modifier = "Mod4";

      input = {
        "type:touchpad" = {
          tap = "enabled";
          dwt = "disabled";
        };
      };

      output = {
        "*".bg = "${config.wallpaper.path} fill";
        "eDP-1".scale = "1.4";
      };

      window.titlebar = false;

      gaps = {
        outer = 3;
        inner = 2;
      };

      bars = [];
      startup = [{ command = "waybar"; }];
      defaultWorkspace = "workspace number 1";

      colors = let
          bg0 = "#1d2021"; bg = "#282828";
          bg3 = "#665c54"; fg = "#ebdbb2";
          fg2 = "d5c4a1"; gray = "#a89984";
          red = "#cc241d"; in
      {
        background = bg;

        focused = {
          background = bg; indicator = bg;
          border = gray; childBorder = gray;
          text = fg;
        };

        focusedInactive = {
          background = bg; indicator = bg;
          border = gray; childBorder = gray;
          text = fg;
        };

        unfocused = {
          background = bg0; indicator = bg0;
          border = bg3; childBorder = bg3;
          text = fg2;
        };

        urgent = {
          background = bg; indicator = bg;
          border = red; childBorder = red;
          text = fg;
        };

        placeholder = {
          background = bg0;
          border = "#0c0c0c";
          childBorder = "#0c0c0c";
          indicator = "#000000";
          text = fg;
        };
      };
    };

    extraConfig = ''
      bindgesture swipe:left workspace prev
      bindgesture swipe:right workspace next
    '';
  };
}
