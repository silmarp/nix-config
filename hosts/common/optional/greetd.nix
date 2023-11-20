{ pkgs, ... }:

{
  # TODO make custom theme import here
  /*
  users.extraUsers.greeter.packages = [
    pkgs.gnome.gnome-themes-extra
    pkgs.materia-theme # Fails to build
  ];
  */

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.gtkgreet}/bin/gtkgreet -c sway";
        user = "greeter";
      };
    };
  };
  /*
  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        theme_name = "Materia-dark";
        icon_theme_name = "Materia-dark";
      };
    };
  };
  */
}
