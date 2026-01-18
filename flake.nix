# /etc/nixos/flake.nix
{
  description = "flake for nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Nur firefox addons.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager,
              nixpkgs-stable, nix-flatpak,
              niri, impermanence, firefox-addons, ... }:
    let system = "x86_64-linux"; in {
          nixosConfigurations.main = nixpkgs.lib.nixosSystem {
            system = "${system}";

            modules = [
              ./hosts/main/configuration.nix

              impermanence.nixosModules.impermanence
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.johannes = {
                  imports = [
                    ./hosts/main/home
                    niri.homeModules.niri
                    nix-flatpak.homeManagerModules.nix-flatpak
                  ];
                };

                # Add firefox addons to home manager arguments.
                home-manager.extraSpecialArgs = { inherit firefox-addons system; };
              }
            ];
          };

          nixosConfigurations.dell = nixpkgs-stable.lib.nixosSystem {
            system = "${system}";

            modules = [
              ./hosts/dell/configuration.nix
            ];
          };
        };
}
