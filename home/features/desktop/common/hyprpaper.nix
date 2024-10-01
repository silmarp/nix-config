{ config, ... }:

{
  services.hyprpaper = {
    enable = true;
    #package = ;
    settings = {
      ipc = "on";
      splash = true;

      preload = [
        "${config.wallpaper}"
      ];
      wallpaper = [
        "eDP-1,${config.wallpaper}"
        "HDMI-A-1,${config.wallpaper}"
      ];
    };
   };
  }
