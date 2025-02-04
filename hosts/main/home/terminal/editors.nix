{pkgs, ...}: {
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
