{pkgs, ...}: {
  services.opensnitch = {
    enable = true;
    settings.ProcMonitorMethod = "ebpf";

    rules = {

      # Allow timesyncd to get time information from the Nixos ntp pool.
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

      # Nsncd rules.
      nsncd = {
        name = "nsncd";
        enabled = true;

        action = "allow";
        duration = "always";
        precedence = false;

        operator = {
          type = "simple";
          operand = "process.path";

          sensitive = true;
          data = "${pkgs.nsncd}/bin/nsncd";
        };
      };

      # Allow mullvad daemon to establish connections.
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

      # Add rule to allow wireguard kernel connections.
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

      # Enable dhcpcd.
      dhcpcd = {
        name = "dhcpcd";
        enabled = true;

        action = "allow";
        duration = "always";

        operator = {
          type = "simple";
          operand = "process.path";

          sensitive = true;
          data = "${pkgs.dhcpcd}/bin/dhcpcd";
        };
      };
    };
  };
}
