{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./gpg.nix
    ./exa.nix
  ];

  home.packages = with pkgs; [
    htop
    zellij
  ];
}
