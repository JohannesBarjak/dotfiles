{pkgs, ...}: {
  # Add emacs server and set it as my default editor.
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  # Main gui text editor.
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      # Navigation and selection plugins for Emacs.
      epkgs.meow epkgs.avy
      epkgs.consult epkgs.vertico
      epkgs.embark epkgs.embark-consult
      epkgs.orderless

      # Language modes.
      epkgs.idris2-mode epkgs.haskell-mode
      epkgs.nix-mode epkgs.markdown-mode
      epkgs.treesit-auto epkgs.nushell-mode

      # Code completion plugins.
      epkgs.corfu
      epkgs.yasnippet

      # Documentation plugins.
      epkgs.marginalia
      epkgs.eldoc-box
      epkgs.consult-hoogle

      # Terminals.
      epkgs.eat epkgs.vterm

      # Magit.
      epkgs.magit epkgs.magit-delta

      # Misc.
      epkgs.doom-themes
      epkgs.pandoc-mode
    ];

    package = pkgs.emacs-pgtk;
  };

  # Copy Emacs elisp configuration into its appropriate folder.
  xdg.configFile."emacs" = {
    source = ./emacs.d;
    recursive = true;
  };
}
