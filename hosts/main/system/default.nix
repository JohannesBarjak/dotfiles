{...}: {
  imports = [
    ./sound.nix
    ./networking.nix
    ./sysd-hardening.nix
    ./snapper.nix
  ];

  programs.firejail = {
    enable = true;
  };

  # Enable printing in my main pc.
  services.printing.enable = true;

  # Avahi is used for printer auto-discovery.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
