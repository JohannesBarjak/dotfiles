{config, pkgs, ...}: {
  wayland.windowManager.mango = {
    enable = true;
    settings =
      builtins.readFile ./config.conf + ''
        exec-once=${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper.path}
        exec-once=${pkgs.waybar}/bin/waybar
      '';

    autostart_sh = ''
    '';
  };
}
