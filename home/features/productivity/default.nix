{ pkgs, ... }:

{
  imports = [
    ./zk.nix
    ./taskwarrior.nix
    ./rbw.nix
  ];

  home.packages = with pkgs; [
    wiki-tui
  ];
}
