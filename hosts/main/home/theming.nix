{pkgs, config, ...}: {
  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    iconTheme.name = "Papirus-Dark";
    iconTheme.package = (pkgs.papirus-icon-theme.override { color = "green"; });

    theme = {
      name = "Orchis-Grey";
      package = pkgs.orchis-theme;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";

    "gtk-3.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/assets";
    "gtk-3.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk.css";
    "gtk-3.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk-dark.css";
  };

  # Cursor theme.
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;

    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  qt = {
    enable = true;

    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # Set Qt theme.
  xdg.configFile."Kvantum" =
    let kvantum-theme = builtins.fetchGit {
          url = "https://github.com/vinceliuice/Orchis-kde.git";
          rev = "d6c86c2460bed343dce068ec9e720ab29fae5d6f";
        };
    in {
      recursive = true;
      source = "${kvantum-theme}/Kvantum";
    };
}
