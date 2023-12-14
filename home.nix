{config, pkgs, ...}: let gtkThemeName = "Gruvbox-Dark-BL"; in {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [ ./fuzzel/fuzzel.nix ];

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

  programs.kitty = {
    enable = true;
    theme = "Gruvbox Material Dark Medium";
    shellIntegration.enableZshIntegration = true;

    settings.background_opacity = "0.82";

    font.name = "FiraCode Nerd Font Mono Reg";
    font.package = ( pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
    font.size = 11;
  };

  # Enable and configure neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      gitsigns-nvim
      neogit
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      cmp-buffer
      lualine-nvim

      (nvim-treesitter.withPlugins ( p: [
        p.c p.lua p.nix
        p.vimdoc p.vim
        p.ini p.haskell
      ]))
    ];
  };

  # Add config dotfiles to xdg-config
  home.file."${config.xdg.configHome}" = {
    source = ./dotfiles/dot_config;
    recursive = true;
  };

  home.stateVersion = "23.11";
}
