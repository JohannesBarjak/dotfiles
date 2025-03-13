{pkgs, ...}: {
  # Main gui text editor.
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.meow epkgs.avy
      epkgs.idris2-mode epkgs.haskell-mode
      epkgs.nix-mode
      epkgs.lsp-mode epkgs.company
      epkgs.eat epkgs.vterm
      epkgs.magit
      epkgs.doom-themes
    ];

    package = pkgs.emacs30-pgtk;
  };

  xdg.configFile."emacs" = {
    source = ./emacs.d;
    recursive = true;
  };
}
