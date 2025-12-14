{pkgs, ...}: {
  # Enable emacs background service.
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = [
    pkgs.texlive.combined.scheme-full
    ];

  # Main gui text editor.
  programs.emacs = {
    enable = true;

    extraPackages = epkgs: [
      # Navigation and selection plugins for Emacs.
      epkgs.avy
      epkgs.consult
      epkgs.vertico
      epkgs.embark
      epkgs.embark-consult
      epkgs.expand-region
      epkgs.orderless
      epkgs.puni

      # Integration with direnv.
      epkgs.envrc

      # Language modes.
      epkgs.treesit-auto
      epkgs.idris2-mode
      epkgs.haskell-mode
      epkgs.nix-mode
      epkgs.markdown-mode
      epkgs.nushell-mode
      epkgs.uiua-ts-mode
      epkgs.bqn-mode
      epkgs.j-mode

      # Code completion plugins.
      epkgs.corfu
      epkgs.yasnippet

      # Editing plugins.
      epkgs.wgrep
      epkgs.multiple-cursors

      # Documentation plugins.
      epkgs.marginalia
      epkgs.eldoc-box
      epkgs.consult-hoogle

      # Terminal related packages.
      epkgs.eat
      epkgs.kkp

      # Git.
      epkgs.magit
      epkgs.magit-delta
      epkgs.git-gutter

      # Misc.
      epkgs.zoom
      epkgs.pandoc-mode
      epkgs.vundo
      epkgs.try

      # Latex.
      epkgs.auctex
      epkgs.cdlatex
      epkgs.org-fragtog

      # Themes.
      epkgs.doom-themes
      epkgs.base16-theme
      epkgs.org-superstar
      epkgs.fira-code-mode
    ];

    package = pkgs.emacs-pgtk;
  };

  # Copy Emacs elisp configuration into its appropriate folder.
  xdg.configFile."emacs" = {
    source = ./emacs.d;
    recursive = true;
  };
}
