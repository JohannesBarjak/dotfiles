# Grabbed this from 'discourse.nixos.org'.
{ pkgs, ... }: {
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
          noto-fonts-cjk-sans
          noto-fonts-emoji

          nerd-fonts.fira-code
          nerd-fonts.cousine
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
