{config, ...}: {
  services.mako = {
    enable = true;

    settings = {
      text-alignment = "center";
      icon-path = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";

      font = "monospace 11";

      # Colors and round borders.
      border-radius = 5;
      background-color = "#282828";
      text-color = "#ebdbb2";
      border-color = "#ebdbb2";
    };
  };
}
