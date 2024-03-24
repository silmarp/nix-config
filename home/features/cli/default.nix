{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./gpg.nix
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./ssh.nix
    ./nix-index.nix
  ];

  home.packages = with pkgs; [
    htop
    zellij

    age # encryption tool
    sops # secret management
  ];
}
