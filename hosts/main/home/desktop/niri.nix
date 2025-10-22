{config, pkgs, ...}: {
  imports = [ ./wallpapers ];

  home.packages = [
    pkgs.niri
    pkgs.nautilus               # Need it for working file picker.
    pkgs.xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      spawn-at-startup = [
        { command = [ "${pkgs.swaybg}/bin/swaybg" "-i" "${config.wallpaper.path}" ]; }
        # Necessary for corectrl and  other privileged applications to work correctly.
        { command = [ "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1" ]; }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+D".action = spawn [ "${config.programs.rofi.package}/bin/rofi" "-show" "combi" ];
        "Mod+T".action = spawn [ "${config.programs.kitty.package}/bin/kitty" "--single-instance" ];
        "Mod+E".action = spawn [ "${config.programs.emacs.finalPackage}/bin/emacsclient" "-n" "-c" ];
        "Mod+B".action = spawn [ "${config.programs.librewolf.package}/bin/librewolf" ];

        # Add useful warpd commands to control the mouse using the keyboard.
        "Mod+G".action = spawn [ "${pkgs.warpd}/bin/warpd" "--grid"   ];
        "Mod+N".action = spawn [ "${pkgs.warpd}/bin/warpd" "--normal" ];
        "Mod+M".action = spawn [ "${pkgs.warpd}/bin/warpd" "--hint"   ];

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

        # Move columns to workspaces using indices.
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;
        "Mod+Ctrl+0".action.move-column-to-workspace = 10;

        # Window focus bindings.
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-right;

        # Window movement bindings;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+L".action = move-column-right;

        # Add keybindings to move to the end of the scroll.
        "Mod+Shift+H".action = focus-column-first;
        "Mod+Shift+L".action = focus-column-last;

        # Keybindings to manage workspaces.
        "Mod+I".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;

        # Centering commands.
        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;

        # Directional column management.
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        # Consume or expel rightward window into focused column.
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        # Add keybindings to swap windows in the style of master-stack layouts.
        "Mod+Ctrl+Comma".action = swap-window-left;
        "Mod+Ctrl+Period".action = swap-window-right;

        # Preset toggles.
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;

        # Different kinds of maximization commands.
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Ctrl+F".action = expand-column-to-available-width;

        # Alternative window management schemes.
        "Mod+W".action = toggle-column-tabbed-display;
        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

        "Mod+Q".action = close-window;

        "Mod+O" = { repeat = false; action = toggle-overview; };

        "Mod+Shift+E".action = quit;
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        # Column and window resizing keybindings.
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action = spawn [ "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%+" ];
        };

        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action = spawn [ "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-" ];
        };

        # Audio control keybindings.
        "XF86AudioMute".action = spawn [
          "${config.programs.nushell.package}/bin/nu" "${./sway/volume.nu}" "--toggle=mute"
        ];

        "XF86AudioRaiseVolume".action = spawn [
          "${config.programs.nushell.package}/bin/nu" "${./sway/volume.nu}" "--inc"
        ];

        "XF86AudioLowerVolume".action = spawn [
          "${config.programs.nushell.package}/bin/nu" "${./sway/volume.nu}" "--dec"
        ];

        # keyboard shortcut to escape applications that grab the keyboard.
        "Mod+Escape" = {
          allow-inhibiting = false;
          action = toggle-keyboard-shortcuts-inhibit;
        };

        # Convenient screenshot shortcuts.
        "Print".action = screenshot;
        # This option is not currently usable due to a bug in nix-flake.
        # "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;
      };

      layout = {
        gaps = 8;
        default-column-width.proportion = 0.5;

        focus-ring = {
          width = 2;
          active.color = "rgb(168 153 132)";
        };
      };

      outputs."eDP-1".scale = 1.33;

      input = {
        touchpad.natural-scroll = false;

        # Configure trackpoint to my preference.
        trackpoint = {
          accel-profile = "flat";
          accel-speed = 0.5;
        };
      };

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

        # Make Emacs occupy half of the screen by default.
        {
          matches = [ { app-id = "librewolf"; } ];
          default-column-width = {};
        }
      ];
    };
  };
}

