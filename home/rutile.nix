{ config, pkgs, ... }:

{
  imports = [ 
    ./global

    ./features/neovim
    ./features/zsh

    ./features/cli
  ];

  home.packages = with pkgs; [
      rnix-lsp
     ];
}
