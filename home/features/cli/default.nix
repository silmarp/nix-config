{ pkgs, ... }:

{
  imports = [];
  home.packages = with pkgs; [
    htop
    zellij
  ];
}
