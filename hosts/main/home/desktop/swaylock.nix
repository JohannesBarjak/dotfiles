{config, pkgs, ...}: {
  imports = [ ./wallpapers ];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      ignore-empty-password = true;

      image = "${config.wallpaper.path}";
      indicator = true;
      indicator-radius = 70;

      effect-blur = "12x5";
    };
  };
}
