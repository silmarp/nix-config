{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./ssh.nix
    ./nix-index.nix
    ./ranger.nix
    ./direnv.nix
  ];

  home.packages = with pkgs; [
    htop
    zellij

    age # encryption tool
    sops # secret management
  ];
}
