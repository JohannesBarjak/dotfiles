{pkgs, ...}: {
  imports = [ ./display-manager.nix ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;
  security.polkit.enable = true;
}
