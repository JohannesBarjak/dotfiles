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
    gnome-disk-utility ventoy-full
    valent
    musescore
    opensnitch-ui
    distrobox distrobox-tui
    (hunspellWithDicts [ hunspellDicts.en-us hunspellDicts.en-us-large ])
    zip unzip
  ];

  home.sessionVariables = {
    GTK_THEME = config.gtk.theme.name;
  };

  programs.bash.enable = true;

  # Configure flatpak packages.
  services.flatpak = {
    enable = true;

    packages = [
      "net.mullvad.MullvadBrowser"
      "org.libreoffice.LibreOffice"
      "net.veloren.airshipper"
      "com.brave.Browser"
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
  services.opensnitch-ui.enable = true;

  services.podman = {
    enable = true;

    containers.local-ai = {
      autoStart = false;
      ports = [ "8080:8080" ];

      devices = [
        "/dev/dri/renderD128:/dev/dri/renderD128"
        "/dev/dri/card1:/dev/dri/card1"
      ];

      volumes = [
        "models:/build/models"
        "photos:/tmp/generated/images/"
      ];

      environment = {
        DEBUG = true;
        SINGLE_ACTIVE_BACKEND = false;
        GGML_SYCL_DEVICE = 0;
        ZES_ENABLE_SYSMAN = 1;
        USE_XETLA = "OFF";
        SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS = 1;
        SYCL_CACHE_PERSISTENT = 1;
      };

      image = "quay.io/go-skynet/local-ai:master-sycl-f16-ffmpeg";
    };
  };

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
