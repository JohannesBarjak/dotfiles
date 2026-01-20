{pkgs, config, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    ./desktop
    ./theming.nix
    ../../../home
  ];

  home.packages = with pkgs; [
    wineWow64Packages.waylandFull winetricks
    bluetuith
    musescore
    opensnitch-ui
    (hunspell.withDicts (d: [ d.en-us-large ]))
    zip unzip
    xournalpp

    # Add custom system update script to system path.
    (writeShellApplication {
      name = "update-system";
      runtimeInputs = [ config.programs.nushell.package ];
      text = ./scripts/update-system.nu;
    })

    podman podman-tui
  ];

  # Opensnitch-ui provides the network request popups.
  services.opensnitch-ui.enable = true;

  home.sessionVariables = {
    GTK_THEME = config.gtk.theme.name;
  };

  programs.bash.enable = true;

  # Password manager.
  programs.keepassxc = {
    enable = true;

    settings = {
      GUI = {
        CompactMode = true;
        ApplicationTheme = "classic";
      };
    };
  };

  # Configure flatpak packages.
  services.flatpak = {
    enable = true;

    packages = [
      "ch.tlaun.TL"
      "com.brave.Browser"
      "com.github.Anuken.Mindustry"
      "com.usebottles.bottles"
      "io.github.flattool.Warehouse"
      "net.mullvad.MullvadBrowser"
      "net.veloren.airshipper"
      "org.libreoffice.LibreOffice"
      "org.onlyoffice.desktopeditors"
      "org.processing.processingide"
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
        Context.sockets = [ "!fallback-x11" "!x11" ];
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

  # Install distrobox for greater package compatibility.
  programs.distrobox.enable = true;

  xdg = {
    enable = true;

    # Enable and configure xdg mime.
    mimeApps = {
      enable = true;

      defaultApplications = {
        # Set firefox as the default browser.
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";

        # Use mpv for video.
        "video/mp4" = "mpv.desktop";

        # Open text files using emacs.
        "text/plain" = "emacs.desktop";
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

  home.stateVersion = "25.11";
}
