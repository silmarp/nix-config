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
        modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "battery" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
         };
        network = {
          interface = "wlp1s0";
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-disconnected = ""; #An empty format will hide the module.
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          # TODO: add on-click open wpa_supplicant_gui
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

