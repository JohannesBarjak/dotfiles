{config, ...}: {
  services.mako = {
    enable = true;

    settings = {
      text-alignment = "center";
      iconPath = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";

      font = "monospace 11";

      # Colors and round borders.
      borderRadius = 5;
      backgroundColor = "#282828";
      textColor = "#ebdbb2";
      borderColor = "#ebdbb2";
    };
  };
}
