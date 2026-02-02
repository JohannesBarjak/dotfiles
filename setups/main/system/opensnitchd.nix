{lib, pkgs, ...}:
# These are simple allow rules that match to an exact binary.
let simple_rules = [
      { name = "dhcpcd"; data = "${pkgs.dhcpcd}/bin/dhcpcd"; }
      { name = "nsncd"; data = "${pkgs.nsncd}/bin/nsncd"; }

      { name = "mullvad-daemon";
        data = "${pkgs.mullvad}/bin/.mullvad-daemon-wrapped";
      }
    ];
    multi_rules = [
      { name = "systemd-timesyncd";
        list = [
          {
            type = "regexp";
            operand = "dest.host";
            data = "\\d\\.nixos\\.pool\\.ntp\\.org";
          }

          {
            type = "simple";
            operand = "process.path";
            data = "${pkgs.systemd}/lib/systemd/systemd-timesyncd";
          }
        ];
      }

      { name = "kworker-wg";
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
      }
    ]; in
{
  services.opensnitch = {
    enable = true;
    settings.ProcMonitorMethod = "ebpf";

    rules = lib.mkMerge [
      # Simple rules that match on the path of the executable.
      (lib.listToAttrs (map (rule: lib.nameValuePair rule.name {
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
     }) simple_rules))

      # Case-sensitive rules that match more complex conditions.
      (lib.listToAttrs (map (rule: lib.nameValuePair rule.name {
       name = rule.name;
       enabled = true;

       action = "allow";
       duration = "always";

       operator = {
         type = "list";
         operand = "list";

         list = map (lib.mergeAttrs { sensitive = true; }) rule.list;
       };
     }) multi_rules))
    ];
  };
}
