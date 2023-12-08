{ lib, pkgs, config, ... }: 

let
wallpaper = builtins.fetchurl {
  url = "https://i.stack.imgur.com/cmoDG.jpg";
  sha256 = "0f701igjzh8593if7z0hzx1aj7cy0c9i0vscs1pdcp16ibp2vy14";
};

in {
  imports = [
    ../common

    ../common/waylandWM/default.nix

    ./keybinds.nix
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
          bg = "${wallpaper} fill";
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
      
      bars = [];
    };
    # TODO use regex for selecting windows 
    extraConfig = ''
      set $opacity 0.9
      for_window [app_id="Alacritty"] opacity $opacity
    '';
  };
}
