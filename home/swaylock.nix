{pkgs, config, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      ignore-empty-password = true;

      image = "${config.stylix.image}";
      indicator = true;
      indicator-radius = 70;

      effect-blur = "12x5";
    };
  };
}
