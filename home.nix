{config, pkgs, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./hyprlandConf.nix;
  };

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

  # swaylock config
  home.file.".config/swaylock/config"= {
    source = ./dotfiles/dot_config/swaylock/config;
  };

  home.stateVersion = "23.11";
}
