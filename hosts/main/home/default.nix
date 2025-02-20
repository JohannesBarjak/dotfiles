{pkgs, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    ./apps
    ./terminal
    ./desktop
    ./theming.nix
    ../../../setups/shared/home
  ];

  home.packages = with pkgs; [
    numbat
    wineWow64Packages.waylandFull winetricks
    jamesdsp bluetuith
    gnome-disk-utility ventoy-full
    valent
    musescore
    tic-80
    mullvad-vpn opensnitch-ui
    distrobox distrobox-tui
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

        "video/mp4" = "celluloid.desktop";
      };
    };

    desktopEntries = {
      firefox = {
        exec = "firejail firefox --name firefox %U";

        name = "Firefox";
        genericName = "Web Browser";
        icon = "firefox";

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

  programs.mpv.enable = true;

  home.stateVersion = "24.05";
}
