{config, lib, rootPath, ...}: let cfg = config.modules.desktop; in {
  config = lib.mkIf (cfg.wm == "mango") {
    hm = {config, pkgs, ...}: {
      # Portals to use with mango.
      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-wlr
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      wayland.windowManager.mango = {
        enable = true;
        settings = builtins.readFile ./config.conf + (with config.lib.stylix.colors; ''
          exec=${pkgs.swaybg}/bin/swaybg -i ${config.stylix.image}

          rootcolor=0x${base00}ff
          bordercolor=0x${base03}ff
          focuscolor=0x${base0D}ff
          maximizescreencolor=0x${base0D}ff
          urgentcolor=0x${base08}ff
          scratchpadcolor=0x${base0C}ff
          globalcolor=0x${base0E}ff
          overlaycolor=0x${base0B}ff

          exec=${config.xdg.configHome}/mango/autostart.sh

          bind=NONE,XF86MonBrightnessUp,spawn,brightnessctl set 5%+
          bind=NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-
      
          bind=NONE,XF86AudioMute,spawn,${config.programs.nushell.package}/bin/nu ${/${rootPath}/home/scripts/volume.nu} --toggle=mute
          bind=NONE,XF86AudioRaiseVolume,spawn,${config.programs.nushell.package}/bin/nu ${/${rootPath}/home/scripts/volume.nu} --inc
          bind=NONE,XF86AudioLowerVolume,spawn,${config.programs.nushell.package}/bin/nu ${/${rootPath}/home/scripts/volume.nu} --dec

          bind=SUPER+ALT,j,spawn,${pkgs.warpd}/bin/warpd --hint
          bind=SUPER+ALT,h,spawn,${pkgs.warpd}/bin/warpd --normal
          bind=SUPER+ALT,g,spawn,${pkgs.warpd}/bin/warpd --grid

          bind=SUPER,b,spawn,${config.programs.librewolf.package}/bin/librewolf
          bind=SUPER+SHIFT,b,spawn,${config.programs.librewolf.package}/bin/librewolf --private-window
        '');

        autostart_sh = builtins.readFile ./autostart.sh;
      };
    };

    # Globally enable mango.
    programs.mango.enable = true;

    # Set rule for low latency in mango.
    services.ananicy.extraRules = [
      { name = "mango"; type = "LowLatency_RT"; }
    ];
  };
}
