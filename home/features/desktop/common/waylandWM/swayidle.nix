{ pkgs, config, ... }: 

{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock"; }
    ];
    timeouts = [
      { timeout = 500; command = "${pkgs.swaylock-effects}/bin/swaylock"; }

      { 
        timeout = 550;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
