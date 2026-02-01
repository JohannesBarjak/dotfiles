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

    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/latest";

    # Nur firefox addons.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-stable, impermanence
            , flatpaks, niri, firefox-addons, stylix, mango, ... }:
    let system = "x86_64-linux"; in {
          nixosConfigurations.main = nixpkgs.lib.nixosSystem {
            system = "${system}";

            modules = [
              ./hosts/main/configuration.nix

              stylix.nixosModules.stylix
              impermanence.nixosModules.impermanence
              mango.nixosModules.mango
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.johannes = {
                  imports = [
                    ./hosts/main/home
                    niri.homeModules.niri
                    flatpaks.homeModules.default
                    mango.hmModules.mango
                  ];
                };

                # Add firefox addons to home manager arguments.
                home-manager.extraSpecialArgs = {
                  inherit firefox-addons system;
                };
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
