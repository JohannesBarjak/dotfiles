# Run hyprland in a dbus session so that xdg-mime works correctly.
{pkgs, ...}: let cmd = "dbus-run-session Hyprland &> /dev/null"; in {
  # Define login manager.
  services.greetd = {
    enable = true;
    vt = 7;

    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -t --asterisks --user-menu --cmd \"${cmd}\"";
      user = "greeter";
    };
  };
}
