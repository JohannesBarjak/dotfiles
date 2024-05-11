{config, pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "sway/workspaces" ];
        modules-center = [ "clock#2" ];
        modules-right = [ "network" "battery" "idle_inhibitor" "clock#1" "group/group-power" ];

        margin = "3 5 0 5";

        "clock#1" = {
          format = "{:%R}";
        };

        "clock#2" = {
          format = "{:%d.%m.%Y}";
        };

        "idle_inhibitor" = {
          format = "{icon}";

          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        network = {
          format-wifi = "{signalStrength}% ";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "Disconnected";

          tooltip-format-wifi = "{essid}";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [""  ""  ""  ""  ""];
        };

        # Found the following on the waybar wiki.
        "group/group-power" = {
          orientation = "inherit";

          drawer = {
            transition-duration = 500;
            children-class = "not-power";
            transition-left-to-right = false;
          };

          modules = [
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };

        # Add custom power modules.
        "custom/quit" = {
          format = "󰗼";
          tooltip = false;
          on-click = "${config.wayland.windowManager.sway.package}/bin/sway exit";
        };

        "custom/lock" = {
          format = "󰍁";
          tooltip = false;
          on-click = "${config.programs.swaylock.package}/bin/swaylock";
        };

        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          on-click = "${pkgs.systemd}/bin/systemctl reboot";
        };

        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
        };
      };
    };
  };
}
