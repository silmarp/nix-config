{ pkgs, ... }:

{
  programs.exa = {
    enable = true;
    #package = pkgs.eza;
    enableAliases = true;
    icons = true;
  };
}
