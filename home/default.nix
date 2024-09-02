{pkgs, ...}: {
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  programs.home-manager.enable = true;

  imports = [
    ./apps
    ./terminal
    ./desktop
    ./theming.nix
  ];

  home.packages = with pkgs; [ numbat ];

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

  # Compose file.
  home.file.".XCompose" = {
    source = ./XCompose;
  };

  home.stateVersion = "23.11";
}
