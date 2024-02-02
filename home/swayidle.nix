{config, pkgs, ...}: {
  # Enable and configure swayidle.
  services.swayidle = {
    enable = true;

    timeouts = [
      { timeout = 300; command = "${pkgs.libnotify}/bin/notify-send 'This computer will suspend soon' -t 15000"; }
      { timeout = 315; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];

    events = [{
      event = "before-sleep";
      command = "${config.programs.swaylock.package}/bin/swaylock -f";
    }];
  };
}
