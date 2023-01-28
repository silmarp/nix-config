{ lib, pkgs, config, ... }: 

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "sway-session.target";
    };
    settings = {
       mainBar = {
         layer = "top";
         position = "top";
         height = 30;
         output = [
           "eDP-1"
         ];
         modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
         modules-center = [ "sway/window" "custom/hello-from-waybar" ];
         modules-right = [ "battery" ];

         "sway/workspaces" = {
           disable-scroll = true;
           all-outputs = true;
         };
         "custom/hello-from-waybar" = {
           format = "hello {}";
           max-length = 40;
           interval = "once";
           exec = pkgs.writeShellScript "hello-from-waybar" ''
             echo "from within waybar"
           '';
         };
        battery = {
          bat = "BAT0";
          interval = 60;
          states = {
              "warning"= 30;
              "critical"= 15;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
      };
    };
  };
}

