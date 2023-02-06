{ lib, pkgs, config, ... }: 

{
  imports = [
    ./waybar.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = true;
    config={
      modifier = "Mod4";
      menu = "dmenu_path | dmenu -b | xargs swaymsg exec";
      terminal = "alacritty";
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
      /*
      TODO: config startup
      startup = [];
      */
      # Using waybar
      bars = [];
      # TODO config keybinds
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
