{config, pkgs, ...}: let gtkTheme = "Gruvbox-Dark-BL"; in {
  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    theme.name = gtkTheme;
    theme.package = pkgs.gruvbox-gtk-theme;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = (pkgs.papirus-icon-theme.override { color = "green"; });
  };

  # Copy gtk-4.0 files, otherwise the theme isn't applied to gtk4 apps.
  xdg.configFile."gtk-4.0" = {
    source = "${config.gtk.theme.package}/share/themes/${gtkTheme}/gtk-4.0";
    recursive = true;
  };

  # This fixes some contrasting issues since the theme is dark.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
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
    platformTheme = "gtk";

    style.name = "gtk2";
  };
}
