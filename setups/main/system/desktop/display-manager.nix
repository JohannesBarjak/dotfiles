{config, pkgs, ...}: {
  # Autologin and window manager startup.
  services.getty.autologinUser = "johannes";

  environment.loginShellInit =  with config.programs; ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      ${uwsm.package}/bin/uwsm start mango-uwsm.desktop
    fi
  '';

  programs.uwsm = {
    enable = true;
    waylandCompositors.mango = {
      binPath = "${pkgs.mangowc}/bin/mango";
      prettyName = "MangoWC";
      comment = "A feature rich Wayland compositor.";
    };
  };
}
