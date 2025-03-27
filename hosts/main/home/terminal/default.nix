{pkgs, config, ...}: {
  imports = [ ./editors.nix ];

  home.packages = with pkgs; [
    nixd markdown-oxide taplo
    typst tinymist
    nodePackages.bash-language-server shellcheck
    vscode-langservers-extracted
    tealdeer
    elvish
  ];

  # Main tui text editor.
  programs.helix = {
    enable = true;
    defaultEditor = true;

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
      background_opacity = 0.85;
    };
  };

  programs.wezterm = {
    enable = true;
  };

  programs.zellij = {
    enable = true;

    settings = {
      theme = "gruvbox-dark";
      default_shell = "${config.programs.nushell.package}/bin/nu";
    };
  };

  # Default shell.
  programs.nushell = {
    enable = true;

    package = pkgs.nushell;
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

    extraConfig = {
      pull.rebase = true;
      http.postBuffer = 10485760; # Set git file size limit in bytes.
    };
  };

  programs.lazygit.enable = true;

  # Terminal document viewers.
  programs.zathura.enable = true;
  programs.sioyek.enable = true;

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
  programs.navi.enable = true;

  programs.pandoc.enable = true;

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

  programs.fd.enable = true;
  programs.ripgrep.enable = true;

  programs.bat = {
    enable = true;
    config.theme = "gruvbox-dark";
  };

  programs.hexchat = {
    enable = true;
    theme = pkgs.fetchzip {
      url = "https://dl.hexchat.net/themes/Zenburn.hct#Zenburn.zip";
      sha256 = "sha256-VIv+IeCwq+jq+F5yyz5J3CSCvQaNh07uc81kVNMqxsY=";
      stripRoot = false;
    };
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
