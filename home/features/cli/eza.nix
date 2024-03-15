{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    #package = pkgs.eza;
    enableZshIntegration = true;
    icons = true;
  };
}
