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
  services.mpris-proxy.enable = true;
  services.opensnitch-ui.enable = true;

  services.podman.enable = true;

  programs.mpv.enable = true;

  home.stateVersion = "24.05";
}
