{pkgs, config, stylix, ...}: {
  # Set gtk theme to Gruvbox and Numix Circle.
  gtk = {
    enable = true;

    iconTheme.name = "Papirus-Dark";
    iconTheme.package = (pkgs.papirus-icon-theme.override { color = "green"; });
  };

  # Cursor theme.
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;

    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  stylix.targets.librewolf.enable = true;
  stylix.targets.librewolf.profileNames = [ "default" ];

  programs.delta.options.syntax-theme = "gruvbox-dark";
  stylix.targets.waybar.enable = false;
  stylix.targets.kitty.fonts.enable = false;
  stylix.targets.rofi.fonts.enable = false;

  stylix.targets.emacs.fonts.enable = false;
  stylix.fonts.sizes.applications = 10;
}
