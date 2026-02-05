{lib, pkgs, ...}:
let lowBrkBoolDirectives = (
      LockPersonality: NoNewPrivileges: PrivateDevices: {
        inherit LockPersonality NoNewPrivileges PrivateDevices;
      });

    restrictDirectives = (
      RestrictRealtime: RestrictSUIDSGID: RestrictNamespaces: {
        inherit RestrictRealtime RestrictSUIDSGID RestrictNamespaces;
      });

    protectionDirectives = (
      ProtectHostname: ProtectControlGroups: ProtectClock: {
        inherit ProtectHostname ProtectControlGroups ProtectClock;
      });

    protectKernel = (protect: {
      ProtectKernelTunables = protect;
      ProtectKernelLogs = protect;
      ProtectKernelModules = protect;
    });

    protectFilesystem = (
      ProtectSystem: ProtectHome: PrivateTmp: ReadWritePaths: {
        inherit ProtectSystem ProtectHome PrivateTmp ReadWritePaths;
      });
in {
  systemd.services = {
    cups.serviceConfig = lib.mkMerge [
      (restrictDirectives true true true)
      (lowBrkBoolDirectives true false false)
      (protectionDirectives true true true)

      (protectKernel true)
      (protectFilesystem "strict" true true
        [ "-/var/spool/cups" "-/var/cache/cups" "-/var/lib/cups" "-/run/cups" ])
    ];

    cups-browsed.serviceConfig = lib.mkMerge [
      (protectKernel true)
      (protectFilesystem "strict" true true
        [ "-/var/cache/cups" "-/var/log/cups" ])
    ];
  };
}
