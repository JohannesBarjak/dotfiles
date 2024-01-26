{config, pkgs, ...}: let gtkThemeName = "Gruvbox-Dark-BL"; in {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [ ./wm/wm.nix ];

  # Enable and configure xdg mime.
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Set firefox as the default browser.
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  # Enable and configure swayidle.
  services.swayidle = {
    enable = true;

    timeouts = [
      { timeout = 300; command = "hyprctl dispatch dpms off"; }
      { timeout = 315; command = "systemctl suspend"; }
    ];

    events = [{
      event = "before-sleep";
      command = "${config.programs.swaylock.package}/bin/swaylock -f";
    }];
  };

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
    x11.enable = true;

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
