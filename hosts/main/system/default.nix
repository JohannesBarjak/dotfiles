{...}: {
  imports = [
    ./sound.nix
    ./networking.nix
    ./tlp.nix
  ];

  programs.firejail = {
    enable = true;
  };
}
