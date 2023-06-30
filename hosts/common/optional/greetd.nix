{ config, lib, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
      # TODO change greet package to ReGreet (or GTKGreet)
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c sway -r --asterisks -t";
        user = "silmar";
      };
      default_session = initial_session;
    };
  };
}
