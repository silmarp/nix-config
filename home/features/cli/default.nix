{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./gpg.nix
    ./eza.nix
  ];

  home.packages = with pkgs; [
    htop
    zellij
  ];
}
