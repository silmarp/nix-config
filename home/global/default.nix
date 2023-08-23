{ inputs, lib, pkgs, config, outputs, nix-colors, ... }:

{
  imports = [
    nix-colors.homeManagerModule.default
  ];

  home = { 
    username = "silmar";
    homeDirectory = "/home/silmar";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";
  };

  colorScheme = lib.mkDefault nix-colors.colorSchemes.tokyo-night;

  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
