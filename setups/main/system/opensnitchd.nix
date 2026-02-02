{lib, pkgs, ...}:
let genSimRule = name: data: { inherit name data; };
    genRule = type: operand: data: { inherit type operand data; };
    # These are simple allow rules that match to an exact binary.
    simpleRules = [
      (genSimRule "dhcpcd" "${pkgs.dhcpcd}/bin/dhcpcd")
      (genSimRule "nsncd" "${pkgs.nsncd}/bin/nsncd")
      (genSimRule "mullvad-daemon" "${pkgs.mullvad}/bin/.mullvad-daemon-wrapped")
    ];

    multiRules = [
      { name = "systemd-timesyncd";
        list = [
          (genRule "regexp" "dest.host" "\\d\\.nixos\\.pool\\.ntp\\.org")
          (genRule "simple" "process.path" "${pkgs.systemd}/lib/systemd/systemd-timesyncd")
        ];
      }

      { name = "kworker-wg";
        list = [
          (genRule "simple" "dest.port" "51820")
          (genRule "simple" "user.id" "0")
          (genRule "simple" "process.path" "Kernel connection")
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
     }) simpleRules))

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
     }) multiRules))
    ];
  };
}
