{ pkgs, ... }:

{
  programs.rbw = {
    enable = true;
    package = pkgs.rbw; 
    settings = {
      email = "silmarjr2@gmail.com";
      pinentry = pkgs.pinentry-gtk2;
      lock_timeout = 300;
    };
  };
}
