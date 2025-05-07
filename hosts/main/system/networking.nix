{pkgs, ...}: {
  systemd.network.enable = true;
  systemd.network.wait-online.anyInterface = true;

  networking = {
    useDHCP = false;
    hostName = "nixos";

    wireless.iwd.enable = true;
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
    };
  };

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
