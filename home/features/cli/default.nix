{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./gpg.nix
    ./eza.nix
    ./git.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    htop
    zellij
  ];
}
