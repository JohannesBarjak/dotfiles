{config, ...}: {
  services.mako = {
    enable = true;

    # Colors and round borders.
    borderRadius = 5;
    backgroundColor = "#282828";
    textColor = "#ebdbb2";
    borderColor = "#ebdbb2";

    font = "monospace 11";
    extraConfig = "text-alignment=center";

    iconPath = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";
  };
}
