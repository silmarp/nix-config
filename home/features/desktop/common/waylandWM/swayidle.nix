{ lib, pkgs, config, ... }: 

{
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fFi ${config.wallpaper}"; }
    ];
    timeouts = [
      { timeout = 500; command = "${pkgs.swaylock}/bin/swaylock -fFi ${config.wallpaper}"; }

      { 
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }

    ];
  };
}
