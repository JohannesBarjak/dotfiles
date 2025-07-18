{pkgs, ...}: {
  environment.systemPackages = [ pkgs.warpd ];

  imports = [
    ./desktop
    ./flatpak-workaround.nix
    ./opensnitchd.nix
  ];

  # Add an overlay for warpd.
  nixpkgs.overlays = [
    (self: super: {
      warpd = (super.warpd.overrideAttrs (old: {
        src = super.fetchFromGitHub {
          owner = "rvaiya";
          repo = "warpd";
          rev = "01650eabf70846deed057a77ada3c0bbb6d97d6e";
          sha256 = "sha256-61+kJvOi4oog0+tGucc1rWemdx2vp15wlluJE+1PzTs=";
        };
      })).override{ withX = false; };
    })
  ];
}
