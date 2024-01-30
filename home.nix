{config, pkgs, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    ./wm/wm.nix
    ./theming.nix
  ];

  xdg = {
    enable = true;

    # Enable and configure xdg mime.
    mimeApps = {
      enable = true;

      defaultApplications = {
        # Set firefox as the default browser.
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };

    # Autogenerate user directories.
    userDirs = {
      enable = true;
      createDirectories = true;
    };
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

  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    extraConfig = "$env.config = { show_banner: false }";
  };

    # Enable Nushell autosuggestions using carapace
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Gruvbox Material Dark Medium";

    settings = {
      scrollback_lines = 1000;
      background_opacity = "0.82";
    };

    font.name = "FiraCode Nerd Font Mono Reg";
    font.package = ( pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
    font.size = 11;
  };

  xdg.desktopEntries = {
    kitty = {
      name = "kitty";
      genericName = "Terminal emulator";
      type = "Application";

      icon = "kitty";
      exec = "kitty --single-instance";
      categories = [ "System" "TerminalEmulator" ];
    };
  };

  # Use helix as an editor.
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor.line-number = "relative";
    };
  };

  programs.wlogout.enable = true;

  home.stateVersion = "23.11";
}
