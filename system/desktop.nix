{pkgs, ...}: {
  # Enable gnome.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [ pkgs.gnome.gnome-software ];

  # Enable flatpak.
  services.flatpak.enable = true;
}
