{pkgs, ...}: {
  # Enable emacs background service.
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

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

      # Integration with direnv.
      epkgs.envrc

      # Language modes.
      epkgs.treesit-auto
      epkgs.idris2-mode
      epkgs.haskell-mode
      epkgs.nix-mode
      epkgs.markdown-mode
      epkgs.nushell-mode

      # Code completion plugins.
      epkgs.corfu
      epkgs.yasnippet

      # Multiple cursors.
      epkgs.multiple-cursors

      # Documentation plugins.
      epkgs.marginalia
      epkgs.eldoc-box
      epkgs.consult-hoogle

      # Terminal related packages.
      epkgs.eat
      epkgs.vterm
      epkgs.kkp

      # Magit.
      epkgs.magit
      epkgs.magit-delta

      # Misc.
      epkgs.pandoc-mode
      epkgs.vundo
      epkgs.try

      # Themes.
      epkgs.doom-themes
      epkgs.base16-theme
    ];

    package = pkgs.emacs-pgtk;
  };

  # Copy Emacs elisp configuration into its appropriate folder.
  xdg.configFile."emacs" = {
    source = ./emacs.d;
    recursive = true;
  };
}
