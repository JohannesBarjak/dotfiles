{pkgs, ...}: {
  programs.nushell = {
    enable = true;

    package = pkgs.nushellFull;
    extraConfig = "$env.config = { show_banner: false, edit_mode: vi }"; # Removes annoying welcome message.
  };

  # Git configuration.
  programs.git = {
    enable = true;

    userName = "Johannes";
    userEmail = "johannes.barjak@gmail.com";

    # Use delta for git diff.
    delta = {
      enable = true;
      options.syntax-theme = "gruvbox-dark";
    };

    extraConfig.pull.rebase = true;
  };

  # Carapace completes command arguments.
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Starship provides a pretty prompt for nushell.
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.alacritty = {
    enable = true;

    settings = {
      import = [ "${pkgs.alacritty-theme}/gruvbox_material.toml" ];

      font = {
        normal.family = "Cousine Nerd Font Mono";
        normal.style = "Regular";
        size = 11;
      };

      window.opacity = 0.8;
      scrolling.history = 1000;
      colors.transparent_background_colors = true;
    };
  };

  # Add extra lsp's for helix
  home.packages = with pkgs; [ nil marksman ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "gruvbox";
      editor.line-number = "relative";
    };
  };

  programs.btop = {
    enable = true;
     settings.color_theme = "gruvbox_material_dark";
  };

  # Tui file manager.
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Zoxide is an autojumping cd.
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "gruvbox-dark";
  };
}
