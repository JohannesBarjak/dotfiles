{rootPath, ...}: {
  imports = [
    ./sound.nix
    ./networking.nix
    ./sysd-hardening.nix
  ];

  # Enable printing in my main pc.
  services.printing.enable = true;

  # Avahi is used for printer auto-discovery.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Set my wallpaper.
  stylix.image = /${rootPath}/home/wallpapers/forest-stairs.jpg;
}
