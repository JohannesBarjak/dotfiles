{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
