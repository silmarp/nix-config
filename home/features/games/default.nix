{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zsnes2 
    osu-lazer
    wine
    steam
    prismlauncher
    lutris
  ];
}
