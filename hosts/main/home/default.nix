{pkgs, config, rootPath, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    /${rootPath}/home
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
      text = /${rootPath}/home/scripts/update-system.nu;
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

    remotes = {
      flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };

    packages = [
      "flathub:app/ch.tlaun.TL//stable"
      "flathub:app/com.brave.Browser//stable"
      "flathub:app/com.github.Anuken.Mindustry//stable"
      "flathub:app/com.usebottles.bottles//stable"
      "flathub:app/io.github.flattool.Warehouse//stable"
      "flathub:app/net.mullvad.MullvadBrowser//stable"
      "flathub:app/net.veloren.airshipper//stable"
      "flathub:app/org.libreoffice.LibreOffice//stable"
      "flathub:app/org.onlyoffice.desktopeditors//stable"
      "flathub:app/org.processing.processingide//stable"
      "flathub:app/org.torproject.torbrowser-launcher//stable"
      "flathub:app/us.zoom.Zoom//stable"
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

  # Install distrobox for greater package availability.
  programs.distrobox.enable = true;

  xdg = {
    enable = true;

    # Enable and configure xdg mime.
    mimeApps = {
      enable = true;

      defaultApplications = {
        # Set librewolf as the default browser.
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";

        # Use mpv for video.
        "video/mp4" = "mpv.desktop";

        # Open text files using emacs.
        "text/plain" = "emacs.desktop";
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
  dconf.settings."org/gnome/desktop/interface".gtk-key-theme = "Emacs";

  programs.mpv.enable = true;

  # Set user specific git information.
  programs.git.settings.user = {
    name = "Johannes";
    email = "johannes.barjak@gmail.com";
  };

  home.stateVersion = "25.11";
}
