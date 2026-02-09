{pkgs, ...}: {
  # Power management service.
  services.upower = {
    enable = true;

    criticalPowerAction = "PowerOff";
    percentageCritical = 5;
    percentageAction = 4;
  };

  # Ananicy is a service which automatically sets process nice levels.
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;

    rulesProvider = pkgs.ananicy-rules-cachyos;
    extraRules = [{ name = "mango"; type = "LowLatency_RT"; }];
  };

  services.auto-cpufreq.enable = true;

  # Tlp can conflict with auto-cpufreq.
  # Prevent the use of Cpu configuration options here.
  services.tlp = {
    enable = true;

    settings = {
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 83;

      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 3;

      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "balanced";
    };
  };
}
