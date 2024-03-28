{pkgs, ...}: {
  home.packages = with pkgs; [
    gradience adw-gtk3
  ];

  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    iconTheme.name = "Papirus-Dark";
    iconTheme.package = (pkgs.papirus-icon-theme.override { color = "green"; });
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3-dark";
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

    platformTheme = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum" = {
    source = builtins.fetchGit {
      url = "https://github.com/sachnr/gruvbox-kvantum-themes.git";
      rev = "f47670be407c1f07c64890ad53884ee9977a7db1";
    };

    recursive = true;
  };
}
