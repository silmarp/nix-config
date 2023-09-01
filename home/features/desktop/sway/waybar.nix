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
        margin-bottom = 0;
        margin-top = 5;
        margin-left = 0;
        margin-right = 0;
        output = [
          "eDP-1"
        ];
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "clock" ];
        modules-right = [ "backlight" "pulseaudio" "bluetooth" "network" "battery" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        clock = {
          format = "{:%A, %d de %B de %Y - %R}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          # TODO: config calendar and on-click open gui calendar app
          calendar = {
            mode           = "year";
            mode-mon-col   = 3;
            weeks-pos      = "right";
            on-scroll      = 1;
            on-click-right = "mode";
            format = {
              months =     "<span color='#ffead3'><b>{}</b></span>";
              days =       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
              today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
        backlight= {
          device= "amdgpu_bl0";
          format= "{percent}% {icon}";
          format-icons= ["" ""];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl s 5%+";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = "";
          # TODO turn packages in variables
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          scroll-step = 1;
          format-icons = ["" "" ""];
        };
        network = {
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "Ethernet ";
          format-disconnected = "No Signal"; #An empty format will hide the module.
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.wpa_supplicant_gui}/bin/wpa_gui";
        };
        battery = {
          bat = "BAT0";
          interval = 60;
          states = {
              "warning"= 30;
              "critical"= 20;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
        bluetooth = {
          format = " {status}";
          # format-connected = " {device_alias}";
          format-connected = " {device_alias} {device_battery_percentage}%";
          interval = 60;
          on-click = "${pkgs.blueman}/bin/blueman-manager";
          # format-connected-battery = " {device_alias} {device_battery_percentage}%";
          format-disabled = " Disabled"; # an empty format will hide the module
          # format-device-preference = [ "device1"; "device2" ], // preference list deciding the displayed device
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
      };
    };
    # TODO make custom style for waybar
    # style = '' '';
  };
}

