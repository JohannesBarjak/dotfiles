{...}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      search.default = "DuckDuckGo";

      settings = {
        "extensions.pocket.enabled" = false;
      };
    }; 
  };
}
