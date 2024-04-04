{pkgs, ...}: {
  home.packages = with pkgs; [
    nil marksman taplo
    vscode-langservers-extracted
  ];

  programs.nushell = {
    enable = true;

    package = pkgs.nushellFull;
    extraConfig = "$env.config = { show_banner: false, edit_mode: vi }"; # Removes annoying welcome message.
  };

  # Git configuration.
  programs.git = {
    enable = true;

    userName = "Johannes";
    userEmail = "johannes.barjak@gmail.com";

    # Use delta for git diff.
    delta = {
      enable = true;
      options.syntax-theme = "gruvbox-dark";
    };

    extraConfig.pull.rebase = true;
  };

  # Carapace completes command arguments.
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Starship provides a pretty prompt for nushell.
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.wezterm = {
    enable = true;

    extraConfig = builtins.readFile ./wezterm.lua;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "gruvbox";
      editor.line-number = "relative";
    };
  };

  programs.btop = {
    enable = true;
     settings.color_theme = "gruvbox_material_dark";
  };

  # Tui file manager.
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Zoxide is an autojumping cd.
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "gruvbox-dark";
  };
}
