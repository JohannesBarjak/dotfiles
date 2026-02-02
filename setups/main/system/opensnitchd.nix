{lib, pkgs, ...}:
# These are simple allow rules that match to an exact binary.
let simple_rules = [
      { name = "dhcpcd"; data = "${pkgs.dhcpcd}/bin/dhcpcd"; }
      { name = "nsncd"; data = "${pkgs.nsncd}/bin/nsncd"; }

      { name = "mullvad-daemon";
        data = "${pkgs.mullvad}/bin/.mullvad-daemon-wrapped";
      }
    ]; in
{
  services.opensnitch = {
    enable = true;
    settings.ProcMonitorMethod = "ebpf";

    rules = lib.mkMerge [
      builtins.listToAttrs (map (rule:
        lib.nameValuePair rule.name {
          name = rule.name;
          enabled = true;

          action = "allow";
          duration = "always";

          operator = {
            type = "simple";
            operand = "process.path";

            sensitive = true;
            data = rule.data;
          };
        }) simple_rules)
      {

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
      }
    ];
  };
}
