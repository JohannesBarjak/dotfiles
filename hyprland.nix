{config, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$menu" = "fuzzel";
      "$terminal" = "kitty";

      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 2;

        # Set border colors.
        "col.active_border" = "rgb(928374)";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };

      bind = [
        # Set audio and mic mute keybindings.
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # Set brightness keys using 'light'.
        ", XF86MonBrightnessUp, exec, light -A 5"
        ", XF86MonBrightnessDown, exec, light -U 5"

        "$mod, L, exec, swaylock -f -C ${config.xdg.configHome}/swaylock/config"

        # Set a few useful bindings.
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, nemo"
        "$mod, R, exec, $menu"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating,"

        # Set scratchpad keybindings.
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Set workspace keybindings.
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      binde = [
        # Set volume keys to execute wireplumber.
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindm = [
        # Drag windows with a left click and resize them with a right click
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "hyprpaper"
        "swayidle -w"
      ];

      input = {
        kb_layout = "us";
        kb_options = "compose:ralt";

        touchpad = {
          natural_scroll = false;
          disable_while_typing = false;
        };
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 4;
          passes = 1;
        };

        layerrule = [ "blur, waybar" ];
      };

      animations = {
        enabled = true;
        animation = "windowsOut, 1, 7, default, popin 70%";
      };

      gestures = {
        # Enables swiping gesture
        workspace_swipe = true;
        workspace_swipe_invert = false;
      };

      misc = {
        # Prevent the default wallpaper from flashing.
        disable_hyprland_logo = true;

        # This enables the display with the mouse or keyboard if it's disabled.
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };
    };
  };
}
