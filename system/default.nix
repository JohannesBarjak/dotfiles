{...}: {
  imports = [
    ./apps
    ./zram.nix
    ./sound.nix
    ./desktop
    ./networking.nix
    ./flatpak-workaround.nix
  ];
}
