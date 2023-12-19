{config, pkgs, ...}: let gtkThemeName = "Gruvbox-Dark-BL"; in {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    ./fuzzel/fuzzel.nix
    ./waybar/config.nix
  ];

  home.sessionVariables = {
    GTK_THEME = gtkThemeName;
  };

  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    theme.name = gtkThemeName;
    theme.package = pkgs.gruvbox-gtk-theme;
    iconTheme.name = "Numix-Circle";
    iconTheme.package = pkgs.numix-icon-theme-circle;
  };

  # Add override for the gtk4 theme
  home.file."${config.xdg.configHome}/gtk-4.0" = {
    source = "${pkgs.gruvbox-gtk-theme}/share/themes/${gtkThemeName}/gtk-4.0";
    recursive = true;
  };

  # Set default cursor size.
  home.pointerCursor = {
    gtk.enable = true;
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    size = 16;
  };

  # Git configuration.
  programs.git = {
    enable = true;
    userName = "Johannes";
    userEmail = "johannes.barjak@gmail.com";

    extraConfig = {
      pull.rebase = true;
    };
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

  programs.nushell = {
    enable = true;
  };

    # Enable Nushell autosuggestions using carapace
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Enable direnv
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Gruvbox Material Dark Medium";
    shellIntegration.enableZshIntegration = true;

    settings.background_opacity = "0.82";

    font.name = "FiraCode Nerd Font Mono Reg";
    font.package = ( pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
    font.size = 11;
  };

  # Use helix as an editor.
  programs.helix = {
    enable = true;
    settings.theme = "gruvbox";
  };

  # Add config dotfiles to xdg-config
  home.file."${config.xdg.configHome}" = {
    source = ./dotfiles/dot_config;
    recursive = true;
  };

  home.stateVersion = "23.11";
}
