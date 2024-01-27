{ lib, pkgs, config, ... }: 

{
  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fFi ~/Pictures/wallpaper.*"; }
    ];
    timeouts = [
      { timeout = 500; command = "${pkgs.swaylock}/bin/swaylock -fFi ~/Pictures/wallpaper.*"; }

      { 
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }

    ];
  };
}
