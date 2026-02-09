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

    # Theme manager for NixOS.
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A wlroots feature rich Wayland compositor.
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-stable, ... }@inputs: {
          nixosConfigurations.main = nixpkgs.lib.nixosSystem {
            specialArgs = with inputs; { inherit emacs-overlay; };

            modules = [
              ./hosts/main/configuration.nix

              inputs.stylix.nixosModules.stylix
              inputs.impermanence.nixosModules.impermanence
              inputs.mango.nixosModules.mango
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.johannes = {
                  imports = [
                    ./hosts/main/home
                    inputs.niri.homeModules.niri
                    inputs.flatpaks.homeModules.default
                    inputs.mango.hmModules.mango
                  ];
                };

                # Add firefox addons to home manager arguments.
                home-manager.extraSpecialArgs = with inputs; {
                  inherit firefox-addons emacs-overlay;
                };
              }
            ];
          };

          nixosConfigurations.dell = nixpkgs-stable.lib.nixosSystem {
            modules = [ ./hosts/dell/configuration.nix ];
          };
        };
}
