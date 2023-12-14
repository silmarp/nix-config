{ inputs, outputs, ... }: {
  imports = [
    ./tailscale.nix
    ./openssh.nix
  ];

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
  };
}
