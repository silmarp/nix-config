{ inputs, outputs, config, lib, ... }: {
  imports = [
    ./tailscale.nix
    ./openssh.nix
  ];

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
