{ pkgs, ... }:

{
  home.packages = [ pkgs.pinentry-curses ];

  programs.gpg = {
    enable = true;
  };
}
