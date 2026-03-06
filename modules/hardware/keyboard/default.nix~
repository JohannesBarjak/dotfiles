{...}: {
  # Kanata is my main keyboard remapping tool.
  services.kanata = {
    enable = true;

    keyboards.myLayout = {
      config = builtins.readFile ./config.kbd;

      extraDefCfg = ''
        process-unmapped-keys yes
        concurrent-tap-hold yes
      '';
    };
  };
}
