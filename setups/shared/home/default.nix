{pkgs, ...}: {
  imports = [ ./emacs ./librewolf.nix ];

  home.packages = [
    pkgs.octaveFull
    pkgs.texmacs pkgs.maxima
  ];
}
