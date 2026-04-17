{...}: {
  modules.containers.nixos = {...}: {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  modules.containers.home = {...}: {
    programs.distrobox = {
      enable = true;
      containers = {
        common-debian = {
          additional_packages = "curl libncurses5 libqt5widgets5 libqt5websockets5 qtwayland5 libxkbcommon0";
          image = "debian:13";
          init_hooks = [
            "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker"
            "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker-compose"
          ];
        };
      };
    };
  };
}
