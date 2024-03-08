{...}: {
  # Enable zram.
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    priority = 100;
    memoryPercent = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 200;
    "vm.page-cluster" = 0;
    "vm.vfs_cache_pressure" = 200;
  };
}
