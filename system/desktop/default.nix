{pkgs, ...}: {
  imports = [ ./display-manager.nix ];

  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;
  security.polkit.enable = true;

  # Allow unlocking with swaylock.
  security.pam.services.swaylock = {};

  # Add udev rules for backlight control.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  # Enable flatpak.
  services.flatpak.enable = true;
}
