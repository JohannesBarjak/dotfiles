{...}: {
  imports = [
    ./apps
    ./flatpak-workaround.nix
    ./zram.nix
    ./sound.nix
    ./desktop.nix
  ];
}
