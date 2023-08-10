{ lib, pkgs, config, ... }: 

{
  imports = [
    ./keybinds.nix
    ./waybar.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.enable = true;
    config = {
      defaultWorkspace = "workspace number 1";
      modifier = "Mod4";
      menu = "${pkgs.wofi}/bin/wofi -S drun";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      input = {
        "*" = {
          xkb_layout = "br";
        };
      };
      output = {
        eDP-1 = {
          res = "1920x1080@60hz";
          bg = "~/Pictures/wallpaper.* fill";
        };
      };
      gaps = {
        inner = 10;
        smartBorders = "on";
        smartGaps = true;
      };
      window = {
        border = 4;
      };
      
      /*
      TODO: config startup
      startup = [];
      */
      # Using waybar
      bars = [];
    };
  };
}
