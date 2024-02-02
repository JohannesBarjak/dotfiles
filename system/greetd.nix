# Run hyprland in a dbus session so that xdg-mime works correctly.
{...}: let cmd = "dbus-run-session Hyprland &> /dev/null"; {
  # Define login manager.
  services.greetd = {
    enable = true;
    vt = 3;

    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -t --asterisks --user-menu --cmd \"${cmd}\"";
      user = "greeter";
    };
  };
}
