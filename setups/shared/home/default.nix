{pkgs, ...}: {
  imports = [ ./emacs ./librewolf.nix ];

  home.packages = [
    pkgs.octaveFull
    pkgs.texmacs pkgs.maxima
    pkgs.lyx
    pkgs.idris2
    pkgs.idris2Packages.idris2Lsp pkgs.idris2Packages.pack
  ];
}
