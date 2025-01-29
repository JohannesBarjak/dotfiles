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
      };

      bookmarks = [
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
}
