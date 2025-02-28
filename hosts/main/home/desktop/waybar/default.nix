{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "clock#2" ];
        modules-right = [ "network" "battery" "idle_inhibitor" "clock#1" "custom/power" ];

        margin = "3 5 0 5";

        "clock#1" = {
          format = "{:%R}";
        };

        "clock#2" = {
          format = "{:%d.%m.%Y}";
        };

        "sway/mode" = {
          format = "{}";
          max-length = 50;
        };

        idle_inhibitor = {
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

        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "${pkgs.systemd}/bin/systemctl poweroff --now";
        };
      };
    };
  };
}
