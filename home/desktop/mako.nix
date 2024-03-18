{config, ...}: {
  services.mako = {
    enable = true;

    # Colors and round borders.
    borderRadius = 5;
    backgroundColor = "#282828df";
    textColor = "#ebdbb2";
    borderColor = "#ebdbb2";

    iconPath = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";
  };
}
