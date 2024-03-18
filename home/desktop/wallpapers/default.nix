{config, lib, ...}: {
  options.wallpaper = {
    path = lib.mkOption {
      type = lib.types.path;
      default = ./pixel-castle.png;

      description = "This option stores which wallpaper to use";
    };
  };
}
