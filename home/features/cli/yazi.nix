{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableNushellIntegration = true;
    shellWrapperName = "yy";
  };
}
