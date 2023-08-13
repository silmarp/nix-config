{ config, pkgs, ... }:

{
  imports = [ 
    ./global

    ./features/neovim
    ./features/zsh
  ];

  home.packages = with pkgs; [
      rnix-lsp
      zellij
      bitwarden
     ];
}
