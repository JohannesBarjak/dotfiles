{...}: {
  services.tlp = {
    enable = true;

    settings = {
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 85;

      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
    };
  };
}
