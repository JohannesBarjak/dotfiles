{...}: {
  services.pulseaudio.enable = false;

  # Enable pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    pulse.enable = true;
    jack.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    wireplumber = {
      enable = true;
      extraConfig = {
        "10-disable-camera" = {
          "wireplumber.profiles" = {
            main."monitor.libcamera" = "disabled";
          };
        };
      };
    };
  };
}
