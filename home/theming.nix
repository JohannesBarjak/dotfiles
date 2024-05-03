{pkgs, ...}: {
  home.packages = with pkgs; [ adw-gtk3 ];

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
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
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

  xdg.configFile."Kvantum" = {
    source = builtins.fetchGit {
      url = "https://github.com/sachnr/gruvbox-kvantum-themes.git";
      rev = "f47670be407c1f07c64890ad53884ee9977a7db1";
    };

    recursive = true;
  };
}
