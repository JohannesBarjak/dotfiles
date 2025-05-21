{pkgs, ...}: {
  networking = {
    # Wireless wifi is managed by iwd.
    wireless.iwd = {
      enable = true;

      # Manage DHCP using iwd.
      settings = {
        General.EnableNetworkConfiguration = true;
      };
    };
    hostName = "nixos";
    nameservers = [ "127.0.0.1" "::1" ];

    useDHCP = false;
  };

  # Use dnscrypt to resolve dns queries.
  services.dnscrypt-proxy2 = {
    enable = true;

    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];

        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    }
    ;
  };

  services.mullvad-vpn.enable = true;

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
