# Concise reference to user's home-manager configuration.
{config, lib, user, ...}: {
  options.hm = lib.mkOption {
    type = lib.types.deferredModule;
    description = "Shorthand for home-manager options.";
  };

  config = {
    home-manager.users.${user} = config.hm;
  };
}
