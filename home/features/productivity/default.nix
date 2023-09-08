{ pkgs, ... }:

{
  imports = [
    ./zk.nix
    ./taskwarrior.nix
  ];

  home.packages = with pkgs; [
    wiki-tui
  ];
}
