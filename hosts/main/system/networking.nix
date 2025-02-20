{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
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
    };
  };

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
