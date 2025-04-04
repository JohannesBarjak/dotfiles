# /etc/nixos/flake.nix
{
  description = "flake for nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = { nixpkgs, home-manager, nixpkgs-stable, nix-flatpak, ... }: {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/main/configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.johannes = {
            imports = [
              ./hosts/main/home
              nix-flatpak.homeManagerModules.nix-flatpak
            ];
          };
        }
      ];
    };

    nixosConfigurations.dell = nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/dell/configuration.nix
      ];
    };

    nixosConfigurations.aspire = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/aspire/configuration.nix
      ];
    };
  };
}
