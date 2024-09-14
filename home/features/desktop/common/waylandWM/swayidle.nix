{ pkgs, config, ... }: 

{
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f --grace 10 --grace-no-mouse"; }
    ];
    timeouts = [
      { timeout = 500; command = "${pkgs.swaylock-effects}/bin/swaylock -f --grace 10 --grace-no-mouse"; }

      { 
        timeout = 550;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
