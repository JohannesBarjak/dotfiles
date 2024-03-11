{config, pkgs, ...}: {
  imports = [ ./wallpapers ];

  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    iconTheme.name = "Papirus-Dark";
    iconTheme.package = (pkgs.papirus-icon-theme.override { color = "green"; });
  };

  dconf.settings = {
    # This fixes some contrasting issues since the theme is dark.
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    # Set the wallpaper.
    "org/gnome/desktop/background"."picture-uri-dark" = "${config.wallpaper.path}";
    "org/gnome/desktop/screensaver"."picture-uri-dark" = "${config.wallpaper.path}";
  };

  # Cursor theme.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    size = 16;
  };

  qt = {
    enable = true;

    platformTheme = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/Gruvbox-Dark-Green" = {
    source = ./Gruvbox-Dark-Green;
    recursive = true;
  };
}
