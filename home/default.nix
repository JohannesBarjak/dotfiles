{config, pkgs, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    ./wm
    ./apps
    ./theming
    ./terminal.nix
  ];

  home.packages = with pkgs; [
    numbat
    mindustry-wayland
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

    # Autogenerate user directories.
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.stateVersion = "23.11";
}
