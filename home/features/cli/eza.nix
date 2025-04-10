{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    #package = pkgs.eza;
    enableZshIntegration = true;
    enableNushellIntegration = false;
    icons = true;
  };
}
