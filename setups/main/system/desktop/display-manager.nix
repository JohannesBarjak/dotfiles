{config, pkgs, ...}: let
  cmd = "${pkgs.mangowc}/bin/mango";
  sessionData = "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"; in {
    services.greetd = {
      enable = true;

      settings = {
        # Autologin into niri.
        initial_session = {
          user = "johannes";
          command = cmd;

        };

        default_session.command =
          "${pkgs.tuigreet}/bin/tuigreet -r -t --asterisks --user-menu --sessions ${sessionData} --cmd '${cmd}'";
      };
    };

    # Got this from 'https://github.com/apognu/tuigreet/issues/68'
    # Prevent tty text from appearing on greetd
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    systemd.services.greetd.environment.RUST_BACKTRACE = "full";
  }
