{ config, ... }:

{
  programs.hyprpaper = {
    enable = true;
    systemd.enable = true;
    #package = ;
    settings = {
      preload = [
        "${config.wallpaper}"
      ];
      wallpapers = [
        "eDP-1,${config.wallpaper}"
      ];
    };
    extraConfig = ''
      splash = true
      ipc = off
    '';
   };
  }
