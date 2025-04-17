{config, lib, pkgs, ...}: {
  imports = [ ./wallpapers ];
  home.packages = [ pkgs.libnotify ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;

    package = pkgs.swayfx;
    checkConfig = false;

    config = let mod = "Mod4"; in {
      menu = "${config.programs.rofi.package}/bin/rofi -show drun";
      terminal = "${config.programs.kitty.package}/bin/kitty --single-instance";
      modifier = mod;

      input = {
        "type:touchpad" = {
          tap = "enabled";
          dwt = "disabled";
        };

        "2:10:TPPS/2_ALPS_TrackPoint" = {
          accel_profile = "adaptive";
          pointer_accel = "1.0";
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
      startup = [
        { command = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"; }
        { command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"; }
        { command = "${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS SWAYSOCK"; }
      ];

      defaultWorkspace = "workspace number 1";

      # Use mkOptiondefault so that default config is not overwritten.
      keybindings = lib.mkOptionDefault {
        "${mod}+c" = "exec ${config.programs.emacs.finalPackage}/bin/emacs";
        "${mod}+g" = "exec ${config.programs.rofi.package}/bin/rofi -show window";
        "${mod}+i" = "exec ${config.programs.librewolf.package}/bin/librewolf";
        "${mod}+tab" = "workspace next_on_output";
        "${mod}+Shift+tab" = "workspace prev_on_output";

        "XF86AudioMute" = "exec ${config.programs.nushell.package}/bin/nu ${./sway/volume.nu} --toggle=mute";
        "XF86AudioRaiseVolume" = "exec ${config.programs.nushell.package}/bin/nu ${./sway/volume.nu} --inc";
        "XF86AudioLowerVolume" = "exec ${config.programs.nushell.package}/bin/nu ${./sway/volume.nu} --dec";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
      };

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

      corner_radius 8

      blur enable
      layer_effects "waybar" {
        blur enable;
        blur_ignore_transparent enable;
      }
    '';
  };
}
