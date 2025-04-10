{pkgs, ...}: {
  # Main gui text editor.
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.meow epkgs.avy
      epkgs.embark
      epkgs.consult
      epkgs.embark-consult
      epkgs.vertico epkgs.orderless
      epkgs.corfu
      epkgs.transient
      epkgs.idris2-mode epkgs.haskell-mode
      epkgs.nix-mode
      epkgs.eldoc-box epkgs.markdown-mode
      epkgs.eat epkgs.vterm
      epkgs.magit epkgs.magit-delta
      epkgs.doom-themes
      epkgs.marginalia
      epkgs.try
      epkgs.yasnippet
      epkgs.pandoc-mode
    ];

    package = pkgs.emacs-pgtk;
  };

  xdg.configFile."emacs" = {
    source = ./emacs.d;
    recursive = true;
  };
}
