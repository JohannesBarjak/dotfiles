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

  # Enable flatpak.
  services.flatpak.enable = true;
}
