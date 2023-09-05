{ config, pkgs, ... }:

{
  imports = [ 
    ./global

    ./features/neovim

    ./features/cli
  ];

  home.packages = with pkgs; [
      rnix-lsp
     ];
}
