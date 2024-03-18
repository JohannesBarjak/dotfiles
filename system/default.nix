{...}: {
  imports = [
    ./apps
    ./zram.nix
    ./sound.nix
    ./desktop
    ./flatpak-workaround.nix
  ];
}
