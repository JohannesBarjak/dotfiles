# Concise reference to user's home-manager configuration.
{config, lib, ...}: {
  options.hm = lib.mkOption {
    type = lib.types.deferredModule;
    description = "Shorthand for home-manager options.";
  };

  options.modules.user = lib.mkOption {
    type = lib.types.str;
    description = "Home manager user.";
  };

  config = {
    home-manager.users.${config.modules.user} = config.hm;
  };
}
