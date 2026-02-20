{...}: {
  config.hm = {config, ...}: {
    services.mako = {
      enable = true;

      settings = {
        text-alignment = "center";
        icon-path = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";

        # Add round borders.
        border-radius = 5;
      };
    };
  };
}
