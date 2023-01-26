{ lib, pkgs, config, ... }: 

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config={
      modifier = "Mod4";
      terminal = "alacritty";
      input = {
        "*" = {
          xkb_layout = "br";
          xkb_variant = "abnt2";
        };
      };
      output = {
        eDP-1 = {
          res = "1920x1080@60hz";
          bg = "~/Pictures/wallpaper.* fill";
        };
      };
      /*
      TODO: config startup
      startup = [];
      */
      #TODO: config bar with status
      bars = [
        {
          position = "top";
        }
      ];
      #TODO config keybinds

      
    };
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    alacritty
    dmenu
    brightnessctl
    grim
    slurp
  ];

  /*
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.sway.extraPackages = with pkgs;    [
      swaylock
      swayidle
      alacritty
      dmenu
      brightnessctl
      grim
      slurp
  ];
  */
}
