{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./nushell.nix
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./ssh.nix
    ./nix-index.nix
    ./ranger.nix
    ./yazi.nix
    ./direnv.nix
    ./gh.nix
  ];

  home.packages = with pkgs; [
    htop
    zellij

    age # encryption tool
    sops # secret management
  ];
}
