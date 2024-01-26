{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      screenshots = true;
      ignore-empty-password = true;

      indicator = true;
      indicator-radius = 70;

      separator-color = "00000000";
      effect-blur = "12x5";

      key-hl-color = "bdae93";
      bs-hl-color = "fb4934";

      inside-color = "282828aa";
      ring-color = "282828";
      text-color = "ebdbb2";
      text-caps-lock-color = "ebdbb2";

      inside-clear-color = "689d6a";
      ring-clear-color = "8ec07c";
      text-clear-color = "ebdbb2";

      inside-ver-color = "d79921";
      ring-ver-color = "fabd2f";
      text-ver-color = "ebdbb2";

      inside-wrong-color = "cc241d";
      ring-wrong-color = "fb4934";
      text-wrong-color = "ebdbb2";
    };
  };
}
