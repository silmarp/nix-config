{ pkgs, lib, config, ... }:

let 
  homeCfgs = config.home-manager.users;
  homeSharePaths = lib.mapAttrsToList (_: v: "${v.home.path}/share") homeCfgs;
  sessionCommand = lib.getExe (pkgs.writeShellScriptBin "sessionCommand" ''
     export XDG_DATA_DIRS="$XDG_DATA_DIRS:${lib.concatStringsSep ":" homeSharePaths}" GTK_USE_PORTAL=0
     ${lib.getExe pkgs.cage} -m last -s -- ${lib.getExe config.programs.regreet.package}
    '');
in
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
        command = "${sessionCommand}";
        user = "greeter";
      };
    };
  };

  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = "${homeCfgs.silmar.wallpaper}";
        fit = "Cover";
      };
    };
  };
}
