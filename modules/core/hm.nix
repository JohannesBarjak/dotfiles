# Concise reference to user's home-manager configuration.
{...}: {
  modules.hm.nixos = {lib, ...}: {
    options.stgs.user.name = lib.mkOption {
      type = lib.types.str;
      description = "Home manager user.";
    };
  };
}
