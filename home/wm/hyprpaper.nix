{config, pkgs, ...}: {
  imports = [ ./wallpapers.nix ];

  home.packages = [ pkgs.hyprpaper ];

  # hyprpaper config.
  xdg.configFile.hyprpaper = {
    text = ''
      splash = false
      preload = ${config.wallpapers.path}/${config.wallpapers.current}
      wallpaper = ,contain:${config.wallpapers.path}/${config.wallpapers.current}
    '';

    target = "hypr/hyprpaper.conf";
  };
}
