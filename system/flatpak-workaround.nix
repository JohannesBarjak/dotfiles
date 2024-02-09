# Grabbed this from 'discourse.nixos.org'.
{ config, pkgs, ... }: {
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
      };

      aggregated = pkgs.buildEnv {
        name = "system-fonts-and-icons";
        paths = with pkgs; [
          numix-icon-theme-circle
          numix-cursor-theme

          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji

          ( nerdfonts.override { fonts = [ "FiraCode" ]; })
        ];

        pathsToLink = [ "/share/fonts" "/share/icons" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
      "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
    };
}
