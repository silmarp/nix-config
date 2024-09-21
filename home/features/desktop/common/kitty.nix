{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      package = pkgs.maple-mono;
      name = "MapleMono";
      size = 16;
    };
    shellIntegration = {
      enableBashIntegration = true;
    };
  };
}
