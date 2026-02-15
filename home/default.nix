{pkgs, ...}: {
  imports = [
    ./emacs
    ./librewolf.nix
    ./mako.nix
    ./mango
    ./niri.nix
    ./rofi
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
    ./terminal.nix
    ./theming.nix
    ./waybar
  ];

  home.packages = [
    pkgs.octaveFull
    pkgs.texmacs pkgs.maxima
    pkgs.lyx
    pkgs.idris2
    pkgs.idris2Packages.idris2Lsp pkgs.idris2Packages.pack
    (pkgs.j.overrideAttrs (oldAttrs: {
      NIX_CFLAGS_COMPILE = " -std=gnu17 -Wno-error";
      NIX_CPPFLAGS_COMPILE = " -include stdint.h";
    }))
    pkgs.uiua
    pkgs.cbqn-replxx pkgs.bqn386
  ];

  # Compose file.
  home.file.".XCompose" = {
    source = ./XCompose;
  };
}
