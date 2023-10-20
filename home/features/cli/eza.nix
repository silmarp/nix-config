{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    #package = pkgs.eza;
    enableAliases = true;
    icons = true;
  };
}
