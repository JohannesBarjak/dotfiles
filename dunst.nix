{...}: {
  services.dunst = {
    enable = true;

    settings = {
        # Use rounded borders.
        global.corner_radius = 5;

        # Color notifications using Gruvbox colors.
        urgency_low = {
          background = "#282828";
          foreground = "#ebdbb2";
        };

          urgency_normal = {
          background = "#282828";
          foreground = "#ebdbb2";
        };

        urgency_critical = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
    };
  };
}
