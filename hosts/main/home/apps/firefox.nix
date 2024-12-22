{...}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;

      search = {
        default = "DuckDuckGo";
        force = true;
      };

      # 'about:config' settings should be set here since they can be ignored
      # when set globally.
      settings = {
        "browser.tabs.inTitlebar" = 0;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
      };
    };
  };
}
