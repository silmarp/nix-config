{
  description = "You new nix config";

  nixConfig = {
    extra-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    website = {
      url = "github:silmarp/site";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    modded-minecraft = {
      url = "github:mkaito/nixos-modded-minecraft-servers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in rec {
      overlays = { default = import ./overlay { inherit inputs; }; };

      templates = import ./templates;

      nixosModules = import ./modules/nixos;

      homeManagerModules = import ./modules/home-manager;

      devShells = forAllSystems (system: {
        default = legacyPackages.${system}.callPackage ./shell.nix { };
      });

      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        });

      nixosConfigurations = {
        pyrolusite = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
          modules = [ ./hosts/pyrolusite/configuration.nix ];
        };
        rutile = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
          modules = [ ./hosts/rutile/configuration.nix ];
        };
        limonite = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
          modules = [ ./hosts/limonite/configuration.nix ];
        };
        hematite = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
          modules = [ ./hosts/hematite/configuration.nix ];
        };
      };

      homeConfigurations = {
        "silmar@pyrolusite" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          }; # Pass flake inputs to our config
          modules = [ ./home/pyrolusite.nix ];
        };
        "silmar@rutile" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          }; # Pass flake inputs to our config
          modules = [ ./home/rutile.nix ];
        };
        "silmar@limonite" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.aarch64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          }; # Pass flake inputs to our config
          modules = [ ./home/limonite.nix ];
        };
        "silmar@hematite" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          }; # Pass flake inputs to our config
          modules = [ ./home/hematite.nix ];
        };
      };
    };
}
