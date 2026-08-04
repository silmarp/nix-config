{ config, pkgs, ... }:

{
  imports = [ 
    ./global

    ./features/helix

    ./features/cli

    ./features/productivity
  ];

  home.packages = with pkgs; [
  ];
}
