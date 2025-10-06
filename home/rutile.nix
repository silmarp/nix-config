{ config, pkgs, ... }:

{
  imports = [ 
    ./global

    ./features/neovim

    ./features/cli

    ./features/productivity
  ];

  home.packages = with pkgs; [
  ];
}
