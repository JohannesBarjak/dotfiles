{...}: {
  imports = [
    ./sound.nix
    ./networking.nix
    ./tlp.nix
  ];

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    
    loadModels = [ "mistral" ];
    rocmOverrideGfx = "gfx902";
  };
}
