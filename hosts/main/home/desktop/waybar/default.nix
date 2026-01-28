{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css; # Need to read file to work with stylix.

    settings = {
      mainBar = let workspace_icons = {
        urgent = "";
        active = "";
        default = "";
      }; in {
        layer = "top";
        modules-left = [ "sway/workspaces" "niri/workspaces" "ext/workspaces" "sway/mode" ];
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

        "ext/workspaces" = {
          format = "{icon}";
          format-icons = workspace_icons;
        };

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = workspace_icons;
        };

        "sway/workspaces" = {
          format = "{icon}";
          format-icons = workspace_icons;
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
