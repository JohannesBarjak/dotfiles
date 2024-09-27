{lib, ...}: {
  options.wallpaper = {
    path = lib.mkOption {
      type = lib.types.path;
      default = ./secluded-grove-pixel.png;

      description = "This option stores which wallpaper to use";
    };
  };
}
