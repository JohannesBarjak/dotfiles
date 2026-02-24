{lib, ...}: {
  modules.wm.nixos = {
    options.modules.wm = lib.mkOption {
      type = lib.types.enum [ "mango" "sway" "niri" ];
      description = "Which window manager to enable.";
    };
  };
}
