{...}: { # Enable and configure waybar
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock#2" ];
        modules-right = [ "wireplumber" "network" "battery" "idle_inhibitor" "clock#1" ];

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

        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "";

          format-icons = {
            headphone = "";
            default = [ "" "" ""];
          };
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [""  ""  ""  ""  ""];
        };
      };
    };
  };
}
