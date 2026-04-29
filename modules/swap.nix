{...}: {
  modules.swap.nixos = {pkgs, ...}:
  let swap_size = 16;
      swap_dir  = "/swap"; in {
    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.pool=zsmalloc"
      "zswap.max_pool_percent=40"
    ];

    boot.initrd.kernelModules = [ "lz4" "lz4_compress" ];

    swapDevices = [{
      device = "${swap_dir}/swapfile";
      size   = swap_size * 1024;
    }];

    systemd.services.perst-swapfile = {
      description = "Create swapfile for zswap.";
      before   = [ "swap.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        type = "oneshot";
        RemainAfterExit = true;
      };

      path = with pkgs; [ btrfs-progs e2fsprogs coreutils ];

      script = ''
        SWAP_FILE="${swap_dir}/swapfile"

        if [ ! -f "$SWAP_FILE" ]; then
          mkdir -p "${swap_dir}"

          touch "$SWAP_FILE"
          chattr +C "$SWAP_FILE" # Disable CoW for swapfile.
          chmod 600 "$SWAP_FILE" # Only allow root access.

          btrfs filesystem mkswapfile --size ${toString swap_size}G "$SWAP_FILE"
        fi
      '';
    };
  };
}
