{...}: {
  modules.swap.nixos = {...}:
  let swap_size = 16;
      swap_dir  = "/swap"; in {
    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.pool=zsmalloc"
      "zswap.max_pool_percent=40"
      "zswap.shrinker_enabled=1"
    ];

    boot.initrd.kernelModules = [ "lz4" "lz4_compress" ];

    swapDevices = [{
      device = "${swap_dir}/swapfile";
      size   = swap_size * 1024;
    }];

    systemd.tmpfiles.rules = [ "v /swap 0700 root root - -" ];
  };
}
