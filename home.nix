{config, pkgs, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [ ./fuzzel/fuzzel.nix ];

  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    theme.name = "Gruvbox-Dark-BL";
    theme.package = pkgs.gruvbox-gtk-theme;
    iconTheme.name = "Numix-Circle";
    iconTheme.package = pkgs.numix-icon-theme-circle;
  };

  # Set default cursor size.
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 16;
  };

  # Enable and configure ags.
  programs.ags = {
    enable = true;
    configDir = ./ags;
    extraPackages = [ pkgs.libsoup_3 ];
  };

  # Git configuration.
  programs.git = {
    enable = true;
    userName = "Johannes";
    userEmail = "johannes.barjak@gmail.com";
  };

  # Use zsh with oh-my-zsh.
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
      background_opacity = "0.82";
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
