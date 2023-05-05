{ config, pkgs, ... }:

{
  imports = [ 
    ./global

    ./features/neovim
  ];

  home.packages = with pkgs; [
      rnix-lsp
      zellij
      bitwarden
     ];
}
