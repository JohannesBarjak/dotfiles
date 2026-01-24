{lib, ...}: {
  options.wallpaper = {
    path = lib.mkOption {
      type = lib.types.path;
      default = ./forest-stairs.jpg;

      description = "This option stores which wallpaper to use";
    };
  };
}
