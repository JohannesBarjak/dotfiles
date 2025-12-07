{...}: {
  imports = [
    ./sound.nix
    ./networking.nix
    ./tlp.nix
    ./sysd-hardening.nix
  ];

  programs.firejail = {
    enable = true;
  };

  # Enable printing in my main pc.
  services.printing.enable = true;

  # Avahi is used for printer auto-discovery.
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
