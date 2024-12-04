{...}: {
  imports = [
    ./zram.nix
    ./sound.nix
    ./desktop
    ./networking.nix
    ./flatpak-workaround.nix
    ./tlp.nix
  ];
}
