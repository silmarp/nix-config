{ lib, pkgs, config, outputs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

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

  home.packages = with pkgs; [ nil nixd ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    targets = {
      hyprland.enable = false;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
