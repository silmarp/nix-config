{ inputs, outputs, ... }: {
  imports = [
    ./tailscale.nix
  ];

  nix = {
    settings = {
      # Enable flakes and 'nix' command
      experimental-features = "nix-command flakes";
	    # Optimazes nix store
	    auto-optimise-store = true;
    };
      # Garbage collection config
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
