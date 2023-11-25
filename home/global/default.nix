{ inputs, lib, pkgs, config, outputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModule
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

  colorScheme = lib.mkDefault inputs.nix-colors.colorSchemes.tokyo-night-dark;

  
  home.packages = with pkgs; [ nil ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
