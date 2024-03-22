# /etc/nixos/flake.nix
{
  description = "flake for nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hosts = {
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, hosts, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit hosts; };

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.johannes = {
              imports = [ ./home ];
            };
          }
        ];
      };
    };
  };
}
