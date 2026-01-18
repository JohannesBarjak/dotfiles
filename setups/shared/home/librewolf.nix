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
        "browser.toolbars.bookmarks.visibility" = "never";

        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "hide-sidebar";

        "webgl.disabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        "privacy.resistFingerprinting.letterboxing" = true;
      };

      # Override minimum window size.
      userChrome = "html { min-width: 0 !important; }";

      bookmarks = {
        force = true;

        settings = [
          # Logic games practice.
          { name = "Syllogimous V4";
            url  = "https://4skinskywalker.github.io/Syllogimous-v4/Intro";
          }

          # Reading to do.
          { name = "Kahne: Multiple Mentality";
            url  = "http://www.rexresearch.com/kahne/kahne.htm";
          }

          # Internship programs.
          { name = "CMU Research Internships";
            url  = "https://www.cmu.edu/scs/s3d/reuse/Research/index.html";
          }

          # Interesting guides to build personal projects.
          {
            name = "Build your own X";
            url = "https://github.com/codecrafters-io/build-your-own-x";
          }
        ];
      };
    };
  };
}
