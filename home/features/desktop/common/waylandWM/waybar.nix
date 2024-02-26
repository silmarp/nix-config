{ lib, pkgs, config, ... }: 

let
  palette = config.colorScheme.palette;
  powermenu = pkgs.writeShellScriptBin "powerMenu"
  ''
    op=$( echo -e " Poweroff\n Reboot\n Lock" | ${pkgs.wofi}/bin/wofi -i --dmenu | ${pkgs.gawk}/bin/awk '{print tolower($2)}' )

    case $op in 
            poweroff)
                exec ${pkgs.systemd}/bin/systemctl poweroff -i
                ;;       
            reboot)
                exec ${pkgs.systemd}/bin/systemctl reboot
                ;;
            lock)
                ${pkgs.swaylock-effects}/bin/swaylock
                ;;
    esac
  '';

in{
  home.packages = [ powermenu ];
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
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
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "backlight" "pulseaudio" "bluetooth" "network" "battery" ];

        "hyprland/workspaces" = {
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
              "warning"= 20;
              "critical"= 5;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
          on-click = "${powermenu}/bin/powerMenu";
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
    style = ''
        * {
            border: none;
            border-radius: 5;
            font-family: Roboto, Helvetica, Arial, sans-serif;
            font-size: 13px;
            min-height: 0;
        }

        window#waybar {
            background: #${palette.base00};
            border-bottom: 3px solid rgba(100, 114, 125, 0.5);
            color: white;
        }

        tooltip {
          background: rgba(43, 48, 59, 0.5);
          border: 1px solid rgba(100, 114, 125, 0.5);
        }
        tooltip label {
          color: white;
        }

        #workspaces button {
            padding: 0 5px;
            background: transparent;
            color: white;
            border-bottom: 3px solid transparent;
        }

        #workspaces button.active {
            background: #64727D;
            border-bottom: 3px solid white;
        }

        #bluetooth,
        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #wireplumber,
        #custom-media,
        #tray,
        #mode,
        #submap,
        #idle_inhibitor,
        #scratchpad,
        #mpd {
            margin-right: 5px;
            margin-left: 5px;
            padding: 0 10px;
            color: #${palette.base00};
            background: #${palette.base0C};
        }

        #battery {
            background-color: #ffffff;
            color: black;
        }

        #battery.charging {
            color: white;
            background-color: #26A65B;
        }

        @keyframes blink {
            to {
                background-color: #ffffff;
                color: black;
            }
        }

        #battery.warning:not(.charging) {
            background: #f53c3c;
            color: white;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }


        #pulseaudio.muted {
            background-color: #90b1b1;
            color: #2a5c45;
        }

        #network.disconnected {
            background-color: red;
        }
    '';
  };
}

