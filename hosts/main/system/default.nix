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
}
