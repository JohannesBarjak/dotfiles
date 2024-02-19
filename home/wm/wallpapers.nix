{config, lib, ...}: let cfg = config.wallpapers; in {
  options.wallpapers = {
    # The full name for the wallpaper should be used
    current = lib.mkOption {
      type = lib.types.str;

      description = "Currently used wallpaper";
    };

    path = lib.mkOption {
      type = lib.types.path;
      default = "${config.xdg.dataHome}/backgrounds";

      description = "Wallpaper folder";
    };
  };

  # Can't source specific wallpapers since that requires
  # absolute paths to be used for the toPath function
  config = {
    home.file."${cfg.path}" = {
      source = ./wallpapers;
      recursive = true;
    };
  };
}
