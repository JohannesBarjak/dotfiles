{...}: {
  services.dunst = {
    enable = true;

    settings = {
        # Global settings.
        global = {
          corner_radius = 5;
          padding = 10;
          font = "Fira Code Mono Medium 9";
          alignment = "center";
          frame_width = 0;
          offset = "15x15";
        };

        # Color notifications using Gruvbox colors.
        urgency_low = {
          background = "#282828df";
          foreground = "#ebdbb2";
        };

          urgency_normal = {
          background = "#282828df";
          foreground = "#ebdbb2";
        };

        urgency_critical = {
          background = "#282828df";
          foreground = "#ebdbb2";
        };
    };
  };
}
