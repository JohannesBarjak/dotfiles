{pkgs, ...}: {
  # Main gui text editor.
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.meow
      epkgs.idris2-mode epkgs.haskell-mode
      epkgs.gruvbox-theme
      epkgs.lsp-mode epkgs.company
      epkgs.nix-mode
    ];

    package = pkgs.emacs30-pgtk;
    extraConfig = builtins.readFile ./init.el;
  };
}
