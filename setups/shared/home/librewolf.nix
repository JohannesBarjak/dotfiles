{...}: {
  programs.librewolf = {
    enable = true;

    profiles.default = {
      isDefault = true;

      search = {
        default = "ddg";
        force = true;
      };

      # 'about:config' settings should be set here since they can be ignored
      # when set globally.
      settings = {
        "browser.tabs.inTitlebar" = 0;
        "webgl.disabled" = false;
      };

      bookmarks = {
        force = true;

        settings = [
          { name = "Syllogimous V4";
            url  = "https://4skinskywalker.github.io/Syllogimous-v4/Intro";
          }
        
          { name = "Kahne: Multiple Mentality";
            url  = "http://www.rexresearch.com/kahne/kahne.htm";
          }

          { name = "CMU Research Internships";
            url  = "https://www.cmu.edu/scs/s3d/reuse/Research/index.html";
          }
        ];
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      ExtensionSettings = {
        # Extension names are based on their id which is visible in about:support.
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        # Note that uMatrix is archived.
        "uMatrix@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/umatrix/latest.xpi";
          installation_mode = "force_installed";
        };

        "CanvasBlocker@kkapsner.de" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/canvasblocker/latest.xpi";
          installation_mode = "force_installed";
        };

        "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
          installation_mode = "force_installed";
        };

        "tridactyl.vim@cmcaine.co.uk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
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

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      DontCheckDefaultBrowser = true;

      # Enable DRM.
      EncryptedMediaExtensions.Enabled = true;
    };
  };
}
