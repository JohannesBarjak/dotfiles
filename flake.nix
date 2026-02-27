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

  outputs = { nixpkgs, home-manager, nixpkgs-stable, ... }@inputs:
let
  rootPath = ./.;
  importTree = dir: let l = nixpkgs.lib;
  in l.filter (p: l.hasSuffix "nix" (toString p) && (baseNameOf p) != "schema.nix")
    (l.filesystem.listFilesRecursive dir);

  modules = nixpkgs.lib.evalModules {
    specialArgs = { inherit inputs rootPath; };
    modules = [ ./modules/schema.nix ] ++ (importTree ./modules);
  };
in {
  nixosConfigurations.main = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs rootPath; };

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

            modules.config.modules."wm/mango".home
            modules.config.modules."desktop/services".home
            modules.config.modules.emacs.home
          ];
        };

        # Add firefox addons to home manager arguments.
        home-manager.extraSpecialArgs = { inherit inputs rootPath; };
      }
      modules.config.modules.hm.nixos
      modules.config.modules.wm.nixos
      modules.config.modules."wm/mango".nixos
      modules.config.modules."desktop/services".nixos
      modules.config.modules.emacs.nixos
    ];
  };

  nixosConfigurations.dell = nixpkgs-stable.lib.nixosSystem {
    modules = [ ./hosts/dell/configuration.nix ];
  };
};
}
