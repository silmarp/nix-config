{ lib, pkgs, config, ... }: 

{
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock"; }
    ];
    timeouts = [
      { timeout = 500; command = "${pkgs.swaylock-effects}/bin/swaylock"; }

      { 
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }

    ];
  };
}
