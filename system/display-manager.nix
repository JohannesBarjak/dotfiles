# Run hyprland on a dbus session so that stuff like xdg-mime works correctly.
{config, pkgs, ...}: let cmd = "dbus-run-session Hyprland &> /dev/null"; in {
  services.greetd = {
    enable = true;

    settings = {
      # Autologin into Hyprland.
      initial_session = {
        user = "johannes";
        command = cmd;
      };

      # Tuigreet will prompt for login whenever I logout.
      default_session = {
        user = "greeter";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -t --asterisks --user-menu --cmd \"${cmd}\"";
      };
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
}
