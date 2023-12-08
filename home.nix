{config, pkgs, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Johannes";
    userEmail = "johannes.barjak@gmail.com";
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "themes" ];
      theme = "gnzh";
    };

    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Gruvbox Material Dark Medium";
    shellIntegration.enableZshIntegration = true;

    settings = {
      shell = "zsh";
      background_opacity = "0.9";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Add config dotfiles to xdg-config
  home.file."${config.xdg.configHome}" = {
    source = ./dotfiles/dot_config;
    recursive = true;
  };

  home.stateVersion = "23.11";
}
