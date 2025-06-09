{config, pkgs, ...}: {
  imports = [ ./wallpapers ];
  home.packages = [ pkgs.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      spawn-at-startup = [
        { command = [ "${pkgs.swaybg}/bin/swaybg" "-i" "${config.wallpaper.path}" ]; }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+D".action = spawn [ "${config.programs.rofi.package}/bin/rofi" "-show" "combi" ];
        "Mod+T".action = spawn [ "${config.programs.kitty.package}/bin/kitty" "--single-instance" ];

        # keybindings to focus on workspaces using numbers.
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+0".action.focus-workspace = 10;

        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-right;

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

