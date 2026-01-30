{...}: {
  systemd.tmpfiles.rules = [ "v /persistent/.snapshots 0700 root root - -" ];

  services.snapper = {
    configs = {
      persistent = {
        SUBVOLUME = "/persistent";

        # Timeline settings.
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
    };
  };
}
