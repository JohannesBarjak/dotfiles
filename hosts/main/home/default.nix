{pkgs, config, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    ./terminal
    ./desktop
    ./theming.nix
    ../../../setups/shared/home
  ];

  home.packages = with pkgs; [
    numbat
    wineWow64Packages.waylandFull winetricks
    bluetuith
    gnome-disk-utility
    valent
    musescore
    opensnitch-ui
    distrobox distrobox-tui
    (hunspellWithDicts [ hunspellDicts.en-us hunspellDicts.en-us-large ])
    zip unzip
  ];

  # Opensnitch-ui provides the network request popups.
  services.opensnitch-ui.enable = true;

  home.sessionVariables = {
    GTK_THEME = config.gtk.theme.name;
  };

  programs.bash.enable = true;

  # Configure flatpak packages.
  services.flatpak = {
    enable = true;

    packages = [
      "ch.tlaun.TL"
      "com.brave.Browser"
      "com.github.Anuken.Mindustry"
      "net.mullvad.MullvadBrowser"
      "net.veloren.airshipper"
      "org.libreoffice.LibreOffice"
      "org.torproject.torbrowser-launcher"
      "us.zoom.Zoom"
    ];

    overrides = {
      global = {
        Environment.GTK_THEME = config.gtk.theme.name;

        Context.filesystems = [
          "/nix/store:ro"
          "xdg-config/gtk-4.0:ro"
          "xdg-config/gtk-3.0:ro"
        ];
      };

      "net.veloren.airshipper" = {
        Context.sockets = "!wayland";
      };

      "org.libreoffice.LibreOffice" = {
        Context = {
          sockets = [
            "!fallback-x11" "!x11"
          ];

          filesystems = [
            "!host" "xdg-documents/LibreOffice"
          ];
        };
      };
    };
  };

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

        "video/mp4" = "celluloid.desktop";
      };
    };

    desktopEntries = {
      librewolf = {
        exec = "librewolf";

        name = "Librewolf";
        genericName = "Web Browser";
        icon = "librewolf";

        mimeType
          = [ "text/html" "text/xml" "application/xhtml+xml"
              "application/vnd.mozilla.xul+xml" "x-scheme-handler/http"
              "x-scheme-handler/https"
        ];

        startupNotify = true;
        terminal = false;
        type = "Application";
      };
    };

    # Autogenerate user directories.
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  # Compose file.
  home.file.".XCompose" = {
    source = ./XCompose;
  };

  services.poweralertd.enable = true;

  # Enabled this service for better bluetooth control of audio devices.
  services.mpris-proxy.enable = true;

  # Make gtk apps use emacs keybindings for text boxes.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-key-theme = "Emacs";
      color-scheme = "prefer-dark";
    };
  };

  programs.mpv.enable = true;

  home.stateVersion = "24.05";
}
