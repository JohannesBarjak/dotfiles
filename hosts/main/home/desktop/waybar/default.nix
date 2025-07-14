{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "sway/workspaces" "niri/workspaces" "sway/mode" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "idle_inhibitor" "wireplumber" "network" "battery" "custom/power" ];

        margin = "3 5 0 5";

        "clock" = {
          format = "{:%R - %d.%m.%Y}";
          tooltip-format = "{calendar}";
        };

        "sway/mode" = {
          format = "{}";
          max-length = 50;
        };

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
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
