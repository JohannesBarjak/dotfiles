{pkgs, config, ...}: {
  home.packages = with pkgs; [
    nixd markdown-oxide taplo
    typst tinymist
    nodePackages.bash-language-server shellcheck
    vscode-langservers-extracted
    tealdeer
  ];

  # Main tui text editor.
  programs.helix = {
    enable = true;

    settings = {
      theme = "gruvbox";
      editor.line-number = "relative";
    };
  };

  # Default terminal.
  programs.kitty = {
    enable = true;
    themeFile = "GruvboxMaterialDarkMedium";

    font = {
      name = "FiraCode Nerd Font Mono";
      package = pkgs.nerd-fonts.fira-code;
      size = 10.5;
    };

    settings = {
      shell = "${config.programs.nushell.package}/bin/nu";
      kitty_mod = "super+ctrl+alt";
      cursor_trail = 3;
    };
  };

  programs.zellij = {
    enable = true;

    settings = {
      theme = "gruvbox-dark";
      default_shell = "${config.programs.nushell.package}/bin/nu";
    };
  };

  # Nushell is my terminal shell.
  programs.nushell = {
    enable = true;

    # Here I can configure $env.config options.
    settings = {
      show_banner = false;
      edit_mode = "emacs";
      cursor_shape.emacs = "line";
    };

    # Shell alias definitions.
    shellAliases = {
      gst = "git status";
      gdf = "git diff";
      enw = "emacsclient -t";
    };
  };

  # Enable direnv to automatically enter nix shell environments.
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;

    # Nix direnv integration.
    nix-direnv.enable = true;
  };

  # Correct incorrect commands in the shell.
  programs.pay-respects = {
    enable = true;
    enableNushellIntegration = true;
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

    extraConfig = {
      pull.rebase = true;
      http.postBuffer = 10485760; # Set git file size limit in bytes.
    };
  };

  programs.lazygit.enable = true;

  # Primary document viewer.
  programs.zathura.enable = true;

  # Carapace completes command arguments.
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Atuin improves the shell's awareness of context in history.
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Starship provides a pretty prompt for nushell.
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  services.pueue.enable = true;

  # Pandoc is a file format converter.
  programs.pandoc.enable = true;

  # Btop is a htop-like resource monitor.
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

  # Add common terminal utilities.
  programs.fd.enable = true;      # Finder.
  programs.fzf.enable = true;     # Fuzzy search.
  programs.ripgrep.enable = true; # Modern grep.

  # Modern terminal file viewer.
  programs.bat = {
    enable = true;
    config.theme = "gruvbox-dark";
  };

  programs.newsboat = {
    enable = true;

    urls = [
      { tags = [ "haskell" "functional programming" ];
        url = "https://planet.haskell.org/rss20.xml";
      }
    ];
  };
}
