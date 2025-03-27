{...}: {
  systemd.services = {
    NetworkManager-dispatcher.serviceConfig = {
      PrivateTmp = true;
      ProtectHome = true;
      ProtectProc = "invisible";
      ProtectSystem = "strict";

      MemoryDenyWriteExecute = true;
      NoNewPrivileges = true;
      RestrictNamespaces = true;
      RestrictSUIDSGID = true;

      ProtectControlGroups = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;

      PrivateMounts = true;
      ProtectClock = true;
      ProtectHostname = true;
      RestrictRealtime = true;

      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW";
      RestrictAddressFamilies = [
        "AF_UNIX"
        "AF_NETLINK"
        "AF_INET"
        "AF_INET6"
        "AF_PACKET"
      ];

      LockPersonality = true;
      SystemCallArchitectures = "native";
      SystemCallFilter = [
        "~@cpu-emulation"
        "~@module"
        "~@mount"
        "~@obsolete"
        "~@swap"
      ];
    };

    NetworkManager.serviceConfig = {
      PrivateTmp = true;
      ProtectHome = true;
      ProtectProc = "invisible";

      MemoryDenyWriteExecute = true;
      NoNewPrivileges = true;
      RestrictNamespaces = true;
      RestrictSUIDSGID = true;

      ProtectControlGroups = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;

      ProtectClock = true;
      ProtectHostname = true;
      RestrictRealtime = true;

      RestrictAddressFamilies = [
        "AF_UNIX"
        "AF_NETLINK"
        "AF_INET"
        "AF_INET6"
        "AF_PACKET"
      ];

      LockPersonality = true;
      SystemCallArchitectures = "native";
      SystemCallFilter = [
        "~@mount"
        "~@module"
        "~@swap"
        "~@obsolete"
        "~@cpu-emulation"
        "ptrace"
      ];
    };
  };
}
