{config, pkgs, ...}: with config; let
  cmd = "${programs.uwsm.package}/bin/uwsm start ${sessionData}/mango-uwsm.desktop";
  sessionData = "${services.displayManager.sessionData.desktops}/share/wayland-sessions"; in {
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

    programs.uwsm = {
      enable = true;
      waylandCompositors.mango = {
        binPath = "${pkgs.mangowc}/bin/mango";
        prettyName = "MangoWC";
        comment = "A feature rich Wayland compositor.";
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
