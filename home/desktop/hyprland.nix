{config, pkgs, ...}: {
  imports = [ ./wallpapers ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$menu" = "rofi -show drun";

      "$terminal" = "sh -c 'alacritty msg create-window || alacritty'";
      "$browser" = "firefox";
      "$filemanager" = "nautilus";

      "$swayosd" = "${pkgs.swayosd}/bin/swayosd-client";
      "$grimblast" = "${pkgs.grimblast}/bin/grimblast";

      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;

        # Set border colors.
        "col.active_border" = "rgb(a89984)";
        "col.inactive_border" = "rgb(665c54)";

        layout = "dwindle";
      };

      dwindle.preserve_split = true;

      bind = [
        # Set audio and mic mute keybindings.
        ", XF86AudioMute, exec, $swayosd --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, $swayosd --input-volume mute-toggle"

        ", XF86MonBrightnessUp, exec, $swayosd --brightness raise"
        ", XF86MonBrightnessDown, exec, $swayosd --brightness lower"

        ", Print, exec, $grimblast save output"
        "$mod, L, exec, swaylock -f"
        ", Caps_Lock, exec, $swayosd --caps-lock-led input0::capslock"

        "$mod, P, exec, $grimblast save active"
        "$mod SHIFT, P, exec, $grimblast save area"
        "$mod ALT, P, exec, $grimblast save output"
        "$mod CTRL, P, exec, $grimblast save screen"

        # Set a few useful bindings.
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, $filemanager"
        "$mod, R, exec, $menu"
        "$mod, B, exec, $browser"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating,"
        "$mod, Z, layoutmsg, togglesplit"

        # Move focus with the arrow keys.
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move windows with the keyboard.
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Scratchpad keybindings.
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Workspace keybindings.
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
        ", XF86AudioRaiseVolume, exec, $swayosd --output-volume raise"
        ", XF86AudioLowerVolume, exec, $swayosd --output-volume lower"

        # Resize windows with the keyboard.
        "$mod ALT, left, resizeactive, -10 0"
        "$mod ALT, right, resizeactive, 10 0"
        "$mod ALT, up, resizeactive, 0 -10"
        "$mod ALT, down, resizeactive, 0 10"
      ];

      bindm = [
        # Drag windows with a left click and resize them with a right click
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.wallpaper.path}"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${pkgs.swayosd}/bin/swayosd-server"
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
          size = 8;
          passes = 2;
        };

        layerrule = [
          "blur, waybar"
          "blur, notifications"
          "blur, rofi"
          "blur, swayosd"

          # Remove blur on mako's and rofi's margin
          "ignorezero, waybar"
          "ignorezero, notifications"
          "ignorezero, rofi"
          "ignorezero, swayosd"
        ];
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
