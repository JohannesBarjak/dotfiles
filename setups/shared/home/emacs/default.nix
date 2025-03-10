{pkgs, ...}: {
  # Main gui text editor.
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.meow
      epkgs.idris2-mode epkgs.haskell-mode
      epkgs.nix-mode
      epkgs.gruvbox-theme
      epkgs.lsp-mode epkgs.company
      epkgs.eat epkgs.vterm
      epkgs.magit
    ];

    package = pkgs.emacs30-pgtk;
  };

  xdg.configFile."emacs" = {
    source = ./emacs.d;
    recursive = true;
  };
}
