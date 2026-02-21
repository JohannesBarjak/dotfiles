{lib, ...}: {
  options.modules.desktop.wm = lib.mkOption {
    type = lib.types.enum [ "mango" "sway" "niri" ];
    description = "Which window manager to enable.";
  };
}
