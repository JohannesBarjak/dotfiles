{...}: {
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      # Disable annoyances.
      DisablePocket = true;

      FirefoxHome = {
        Pocket = false;
        SponsoredTopSites = false;
      };

      UserMessaging = {
        MoreFromMozilla = false;
        SkipOnboarding = true;
        FeatureRecommendations = false;
        ExtensionRecommendations = false;
      };

      FirefoxSuggest.WebSuggestions = false;
      DontCheckDefaultBrowser = true;

      # Enable DRM.
      EncryptedMediaExtensions.Enabled = true;
    };
  };
}
