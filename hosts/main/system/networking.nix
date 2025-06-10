{pkgs, ...}: {
  networking = {
    # Wireless wifi is managed by iwd.
    wireless.iwd.enable = true;
    hostName = "nixos";

    useDHCP = true;
  };

  services.mullvad-vpn.enable = true;

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
