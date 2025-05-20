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

  services.opensnitch = {
    enable = true;
    settings.ProcMonitorMethod = "ebpf";

    rules = {
      systemd-timesyncd = {
        name = "systemd-timesyncd";
        enabled = true;

        action = "allow";
        duration = "always";

        operator = {
          type = "list";
          operand = "list";

          list = [
            {
              type = "regexp";
              operand = "dest.host";

              sensitive = true;
              data = "\\d\\.nixos\\.pool\\.ntp\\.org";
            }

            {
              type = "simple";
              operand = "process.path";

              sensitive = true;
              data = "${pkgs.systemd}/lib/systemd/systemd-timesyncd";
            }
          ];
        };
      };

      nsncd = {
        name = "nsncd";
        enabled = true;

        action = "allow";
        duration = "always";
        precedence = false;

        operator = {
          type = "list";
          operand = "list";

          list = [
            {
              type = "simple";
              operand = "process.path";

              sensitive = true;
              data = "${pkgs.nsncd}/bin/nsncd";
            }

            {
              type = "simple";
              operand = "dest.host";

              sensitive = true;
              data = "ipv4.am.i.mullvad.net";
            }
          ];
        };
      };

      mullvad-daemon = {
        name = "mullvad-daemon";
        enabled = true;

        action = "allow";
        duration = "always";

        operator = {
          type = "simple";
          operand = "process.path";

          sensitive = true;
          data = "${pkgs.mullvad}/bin/.mullvad-daemon-wrapped";
        };
      };

      kworker-wg = {
        name = "kworker-wg";
        enabled = true;

        action = "allow";
        duration = "always";

        operator = {
          type = "list";
          operand = "list";
          sensitive = true;

          list = [
            {
              type = "simple";
              operand = "dest.port";
              data = "51820";
            }

            {
              type = "simple";
              operand = "user.id";
              data = "0";
            }

            {
              type = "simple";
              operand = "process.path";
              data = "Kernel connection";
            }
          ];
        };
      };
    };
  };

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
