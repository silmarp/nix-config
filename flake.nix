{
  description = "You new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix-colors
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in rec {
      # Your custom packages and modifications
      overlays = {
        default = import ./overlay { inherit inputs; };
      };

      templates = import ./templates;

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system: {
        default = legacyPackages.${system}.callPackage ./shell.nix { };
      });

      # This instantiates nixpkgs for each system listed above
      # Allowing you to add overlays and configure it (e.g. allowUnfree)
      # Our configurations will use these instances
      # Your flake will also let you access your package set through nix build, shell, run, etc.
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          # This adds our overlays to pkgs
          overlays = builtins.attrValues overlays;
          # NOTE: Using `nixpkgs.config` in your NixOS config won't work
          # Instead, you should set nixpkgs configs here
          # (https://nixos.org/manual/nixpkgs/stable/#idm140737322551056)

          config.allowUnfree = true;
        }
      );

      nixosConfigurations = {
        pyrolusite = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = (builtins.attrValues nixosModules) ++ [
            # > Our main nixos configuration file <
            ./hosts/pyrolusite/configuration.nix
          ];
        };
	      rutile = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = (builtins.attrValues nixosModules) ++ [
            # > Our main nixos configuration file <
            ./hosts/rutile/configuration.nix
          ];
        };
        limonite = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.aarch64-linux;
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = (builtins.attrValues nixosModules) ++ [
            # > Our main nixos configuration file <
            ./hosts/limonite/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "silmar@pyrolusite" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
            modules = (builtins.attrValues homeManagerModules) ++ [
              # > Our main home-manager configuration file <
              ./home/pyrolusite.nix
            ];
        };
        "silmar@rutile" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
            modules = (builtins.attrValues homeManagerModules) ++ [
              # > Our main home-manager configuration file <
              ./home/rutile.nix
            ];
        };
        "silmar@limonite" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = legacyPackages.aarch64-linux;
            extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
            modules = (builtins.attrValues homeManagerModules) ++ [
              # > Our main home-manager configuration file <
              ./home/limonite.nix
            ];
        };
      };
    };
}
