{...}: {
  imports = [
    ./sound.nix
    ./networking.nix
    ./tlp.nix
  ];

  services.ollama = {
    enable = true;
    loadModels = [ "mistral" ];
  };
}
