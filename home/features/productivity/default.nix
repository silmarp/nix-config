{ pkgs, ... }:

{
  imports = [
    ./zk.nix
    ./rbw.nix
    ./syncthing.nix
  ];
  home.packages = [
    pkgs.taskwarrior3
  ];
  home.shellAliases = {
    t = "task";
    tt = "task +today";
  };
}
