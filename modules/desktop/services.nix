{...}: {
  modules."desktop/services".nixos =  {...}: {
    # Allow unlocking with swaylock.
    security.pam.services.swaylock = {};
  };

  modules."desktop/services".home = {config, pkgs, ...}: {
    services.mako = {
      enable = true;

      settings = {
        text-alignment = "center";
        icon-path = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";

        # Add round borders.
        border-radius = 5;
      };
    };

    # Enable and configure swayidle.
    services.swayidle = {
      enable = true;

      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.libnotify}/bin/notify-send -i dialog-warning 'This computer will suspend soon' -t 15000";
        }

        { timeout = 315; command = "${pkgs.systemd}/bin/systemctl suspend"; }
      ];

      events.before-sleep = "${config.programs.swaylock.package}/bin/swaylock -f";
    };

    # Enable and configure the lockscreen.
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;

      settings = {
        clock = true;
        ignore-empty-password = true;

        image = "${config.stylix.image}";
        indicator = true;
        indicator-radius = 70;

        effect-blur = "12x5";
      };
    };
  };
}
