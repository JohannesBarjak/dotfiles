{pkgs, ...}: {
  home.packages = with pkgs; [
    helvum
    celluloid loupe
    gnomeExtensions.blur-my-shell
    wineWowPackages.waylandFull bottles
    gradience adw-gtk3
  ];

  dconf.settings = {
    # Disable search providers.
    "org/gnome/desktop/search-providers" = {
      disabled = [
        "org.gnome.Characters.desktop"
        "org.gnome.Epiphany.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Contacts.desktop"
      ];
    };
  };
}
