{config, pkgs, ...}: let gtkTheme = "Gruvbox-Dark-BL"; in {
  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    theme.name = gtkTheme;
    theme.package = pkgs.gruvbox-gtk-theme;
    iconTheme.name = "Numix-Circle";
    iconTheme.package = pkgs.numix-icon-theme-circle;
  };

  home.sessionVariables.GTK_THEME = gtkTheme;

  # Copy gtk-4.0 files, otherwise the theme isn't applied to gtk4 apps.
  home.file."${config.xdg.configHome}/gtk-4.0" = {
    source = "${pkgs.gruvbox-gtk-theme}/share/themes/${gtkTheme}/gtk-4.0";
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
}
