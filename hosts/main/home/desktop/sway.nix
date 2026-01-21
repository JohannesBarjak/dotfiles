{config, lib, pkgs, ...}: {
  imports = [ ./wallpapers ];
  home.packages = [ pkgs.libnotify pkgs.jq ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;

    package = pkgs.swayfx;
    checkConfig = false;

    config = let mod = "Mod4"; in {
      menu = "${config.programs.rofi.package}/bin/rofi -show combi";
      terminal = "${config.programs.kitty.package}/bin/kitty --single-instance";
      modifier = mod;

      input = {
        "type:touchpad" = {
          tap = "enabled";
          dwt = "disabled";
        };

        "2:10:TPPS/2_ALPS_TrackPoint" = {
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
      };

      output = {
        "*".bg = "${config.wallpaper.path} fill";
        "eDP-1".scale = "1.4";
      };

      window = {
        titlebar = false;

        # Window specific rules.
        commands = [
          {
            # This rule makes OpenSnitch popups floating.
            command = "floating enable";
            criteria = {
              app_id = "opensnitch_ui";
            };
          }
        ];
      };

      gaps = {
        outer = 2; inner = 2;
        smartBorders = "on";
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
        "${mod}+Ctrl+space" = "exec ${config.programs.emacs.finalPackage}/bin/emacsclient -n -c";
        "${mod}+Ctrl+r" = "exec ${pkgs.mullvad}/bin/mullvad reconnect";
        "${mod}+i" = "exec ${config.programs.librewolf.package}/bin/librewolf";

        "${mod}+h" = "exec ${pkgs.sway-overfocus}/bin/sway-overfocus split-lt float-lt output-lt";
        "${mod}+j" = "exec ${pkgs.sway-overfocus}/bin/sway-overfocus split-dt float-dt output-dt";
        "${mod}+k" = "exec ${pkgs.sway-overfocus}/bin/sway-overfocus split-ut float-ut output-ut";
        "${mod}+l" = "exec ${pkgs.sway-overfocus}/bin/sway-overfocus split-rt float-rt output-rt";

        "${mod}+Period" = "exec ${pkgs.sway-overfocus}/bin/sway-overfocus group-rw group-dw";
        "${mod}+Comma"  = "exec ${pkgs.sway-overfocus}/bin/sway-overfocus group-lw group-uw";

        # Add hints from warpd.
        "${mod}+m" = "exec ${pkgs.warpd}/bin/warpd --hint";
        "${mod}+c" = "exec ${pkgs.warpd}/bin/warpd --grid";
        "${mod}+x" = "exec ${pkgs.warpd}/bin/warpd --normal";

        # Add binding for focus on child.
        "${mod}+s" = "focus child";
        "${mod}+Ctrl+s" = "exec ${config.programs.nushell.package}/bin/nu ${./sway/focus_visible.nu}";

        "XF86AudioMute" = "exec ${config.programs.nushell.package}/bin/nu ${./sway/volume.nu} --toggle=mute";
        "XF86AudioRaiseVolume" = "exec ${config.programs.nushell.package}/bin/nu ${./sway/volume.nu} --inc";
        "XF86AudioLowerVolume" = "exec ${config.programs.nushell.package}/bin/nu ${./sway/volume.nu} --dec";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
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
