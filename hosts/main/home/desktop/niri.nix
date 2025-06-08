{config, pkgs, ...}: {
  home.packages = [ pkgs.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      binds = with config.lib.niri.actions; {
        "Mod+D".action = spawn [ "${config.programs.rofi.package}/bin/rofi" "-show" "combi" ];
        "Mod+T".action = spawn [ "${config.programs.kitty.package}/bin/kitty" "--single-instance" ];
        "Mod+1".action.focus-workspace = 1;

        "Mod+Shift+Q".action = close-window;

        "Mod+Shift+E".action = quit;

        "XF86MonBrightnessUp".action = spawn [ "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%+" ];
        "XF86MonBrightnessDown".action = spawn [ "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-" ];
      };

      layout = {
        gaps = 8;
        focus-ring = {
          width = 2;
          active.color = "rgb(168 153 132)";
        };
      };

      outputs."eDP-1".scale = 1.4;

      input.touchpad.natural-scroll = false;
      prefer-no-csd = true;

      window-rules = [
        # Open opensnitch popups in floating mode.
        {
          matches = [ { app-id = "opensnitch_ui"; } ];
          open-floating = true;
        }

        # Enable rounded corners in all windows.
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };

          clip-to-geometry = true;
        }
      ];
    };
  };
}

