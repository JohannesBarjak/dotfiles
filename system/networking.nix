{pkgs, hosts ,...}: {
  environment.systemPackages = [ pkgs.openvpn ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

  networking.extraHosts = builtins.readFile hosts;

  # Add vpn.
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
