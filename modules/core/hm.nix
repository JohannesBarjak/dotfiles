# Concise reference to user's home-manager configuration.
{...}: {
  modules.hm.nixos = {lib, ...}: {
    options.modules.user = lib.mkOption {
      type = lib.types.str;
      description = "Home manager user.";
    };
  };
}
