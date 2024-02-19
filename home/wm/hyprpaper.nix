{pkgs, ...}: {
  home.packages = [ pkgs.hyprpaper ];

  # hyprpaper config.
  xdg.configFile.hyprpaper = {
    text = ''
      splash = false
      preload = ~/.local/share/backgrounds/pixel-castle.png
      wallpaper = ,contain:~/.local/share/backgrounds/pixel-castle.png
    '';

    target = "hypr/hyprpaper.conf";
  };
}
