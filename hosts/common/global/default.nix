{ inputs, outputs, config, lib, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./tailscale.nix
    ./openssh.nix
    ./sops.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      # Enable flakes and 'nix' command
      experimental-features = "nix-command flakes";
	    # Optimazes nix store
	    auto-optimise-store = true;
      # Gives permission to build for other hosts
      trusted-users = [ "root" "@wheel" ];
    };
      # Garbage collection config
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = ["/etc/nix/path"];
  };
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;
}
