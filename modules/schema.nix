{ lib, ... }: {
  options.modules = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.submodule {
      options = {
        nixos = lib.mkOption {
          type = lib.types.deferredModule;
          default = {};
        };
        home = lib.mkOption {
          type = lib.types.deferredModule;
          default = {};
        };
      };
    });
  };
}
