{pkgs, ...}: {
  imports = [ ./emacs ./librewolf.nix ];

  home.packages = [ pkgs.octaveFull ];
}
