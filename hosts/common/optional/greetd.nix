{ pkgs, lib, config, ... }:

{
  users.extraUsers.greeter = {
    # Does not work without
    home = "/tmp/greeter-home";
    createHome = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.cage} -m last -s -- ${lib.getExe config.programs.regreet.package}";
        user = "greeter";
      };
    };
  };
  programs.regreet = {
    enable = true;
  };
}
