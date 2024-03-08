{...}: {
  imports = [
    ./apps
    ./display-manager.nix
    ./flatpak-workaround.nix
    ./zram.nix
  ];
}
