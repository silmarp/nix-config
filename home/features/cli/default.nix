{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./gpg.nix
  ];

  home.packages = with pkgs; [
    htop
    zellij
  ];
}
