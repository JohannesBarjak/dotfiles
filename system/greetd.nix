# Run hyprland in a dbus session so that xdg-mime works correctly.
{pkgs, ...}: let cmd = "dbus-run-session Hyprland &> /dev/null"; in {
  # Define login manager.
  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -t --asterisks --user-menu --cmd \"${cmd}\"";
      user = "greeter";
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
