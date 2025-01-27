{...}: {
  imports = [
    ./sound.nix
    ./networking.nix
    ./tlp.nix
  ];

  services.ollama = {
    enable = true;
    acceleration = "rocm";

    rocmOverrideGfx = "9.0.0";
  };
}
