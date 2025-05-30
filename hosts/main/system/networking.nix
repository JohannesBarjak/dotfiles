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

    useDHCP = false;
  };

  services.mullvad-vpn.enable = true;

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
