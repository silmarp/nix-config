{ config, lib, pkgs, ... }:

{
  # TODO make custom theme import here
  users.extraUsers.greeter.packages = [
    pkgs.gnome.gnome-themes-extra
    pkgs.materia-theme
  ];

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet -l debug";
        user = "greeter";
      };
      default_session = initial_session;
    };
  };
  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        theme_name = "Materia-dark";
        icon_theme_name = "Materia-dark";
      };
    };
  };
}
