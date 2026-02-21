{pkgs, ...}: {
  imports = [ ./display-manager.nix ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;
  security.polkit.enable = true;

  # Enable flatpak.
  services.flatpak.enable = true;
}
