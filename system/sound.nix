{...}: {
  hardware.pulseaudio.enable = false;

  # Enable pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
