{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        modules-left = [ "sway/workspaces" "niri/workspaces" "tray" "sway/mode" ];
        modules-center = [ "clock#2" ];
        modules-right = [ "network" "wireplumber" "battery" "idle_inhibitor" "clock#1" "custom/power" ];

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

        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = ["" "" ""];
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [
            "<span color=\"#fb4934\"></span>"
            "<span color=\"#fabd2f\"></span>"
            "<span color=\"#b8bb26\"></span>"
            "<span color=\"#b8bb26\"></span>"
            ""
          ];
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
