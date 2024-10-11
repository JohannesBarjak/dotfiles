{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.meow
      epkgs.idris2-mode epkgs.haskell-mode
      epkgs.org
      epkgs.gruvbox-theme
      epkgs.lsp-mode epkgs.company
    ];

    package = pkgs.emacs30-pgtk;
    extraConfig = builtins.readFile ./init.el;
  };

  programs.vscode = {
    enable = true;
  };

  programs.kakoune = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  };
}
