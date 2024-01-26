{...}: {
  # Enable and configure fuzzel
  programs.fuzzel.enable = true;

  programs.fuzzel.settings = {
    main = {
      icon-theme = "Numix-Circle";
      exit-on-keyboard-focus-loss = false;
      width = 30;
      inner-pad = 10;
      vertical-pad = 15;
      dpi-aware = "yes";
      font = "Fira Code Mono Medium:size=13";
    };

    colors = {
      background = "1d2021ff";
      text = "ebdbb2ff";
      selection = "ebdbb2ff";
      selection-text = "3c3836ff";
      match = "cc241dff";
      selection-match = "fb4934ff";
      border = "928374ff";
    };
  };
}
