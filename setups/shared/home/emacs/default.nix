{pkgs, ...}: {
  # Main gui text editor.
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.meow epkgs.avy
      epkgs.idris2-mode epkgs.haskell-mode
      epkgs.nix-mode
      epkgs.corfu
      epkgs.eldoc-box epkgs.markdown-mode
      epkgs.eat epkgs.vterm
      epkgs.magit epkgs.magit-delta
      epkgs.doom-themes
      epkgs.transient
      epkgs.vertico epkgs.orderless
      epkgs.marginalia
      epkgs.embark
      epkgs.consult
      epkgs.try
    ];

    package = pkgs.emacs-pgtk;
  };

  xdg.configFile."emacs" = {
    source = ./emacs.d;
    recursive = true;
  };
}
