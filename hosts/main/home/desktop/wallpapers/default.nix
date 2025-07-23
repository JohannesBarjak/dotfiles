{lib, ...}: {
  options.wallpaper = {
    path = lib.mkOption {
      type = lib.types.path;
      default = ./skyline.png;

      description = "This option stores which wallpaper to use";
    };
  };
}
