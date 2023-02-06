{ lib, pkgs, config, ... }: 

{
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock-fFi ~/Pictures/wallpaper.* fill"; }
    ];
    timeouts = [
      { timeout = 500; command = "${pkgs.swaylock}/bin/swaylock -fFi ~/Pictures/wallpaper.* fill"; }
    ];
  };
}
