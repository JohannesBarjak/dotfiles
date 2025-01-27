{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  services.mullvad-vpn.enable = true;

  services.opensnitch.enable = true;
  services.opensnitch-ui.enable = true;

  # Add vpn.
  environment.systemPackages = [ pkgs.openvpn ];
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
