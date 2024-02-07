{ config, pkgs, ... }:

{
  imports = [
    ../common
    ../common/waylandWM/default.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
      };

      input = {
        kb_layout = "br";
      };

      "$mod" = "SUPER";
      "$menu" = "${pkgs.rofi-wayland}/bin/rofi -show drun";
      "$lock" = "${pkgs.swaylock-effects}/bin/swaylock";
      "$grimblast" = "${pkgs.grimblast}/bin/grimblast --notify copy ";
      "$brightnessctl" = "${pkgs.brightnessctl}/bin/brightnessctl s"; 
      "$wpvolume" = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@";
      "$wpmute" = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

      bind = [
        "$mod, Return, exec, alacritty"
        "$mod Shift, q, killactive"
        "$mod, d, exec, $menu"

        # Move focus with mainMod + arrow keys
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        # Toggle fullscreen
        "$mod, f, fullscreen"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Move active window to a direction
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        # Resize window


        # Scratchpad
        "$mod, Space, togglespecialworkspace, magic"
        "$mod SHIFT, Space, movetoworkspace, special:magic"
 
        "$mod, F10, exec, $lock"

        ",XF86AudioRaiseVolume, exec, $wpvolume 0.05+"
        ",XF86AudioLowerVolume, exec, $wpvolume 0.05-"
        ",XF86AudioMute, exec, $wpmute"

        ",XF86MonBrightnessUp, exec, $brightnessctl 5%+"
        ",XF86MonBrightnessDown, exec, $brightnessctl 5%-"

        ",Print, exec, $grimblast output"
        "$mod Shift, s, exec, $grimblast area"
      ];
    };
    extraConfig = ''
      # window resize
      bind = $mod, r, submap, resize

      submap = resize
      binde = , h, resizeactive, -10 0
      binde = , j, resizeactive, 0 10
      binde = , k, resizeactive, 0 -10
      binde = , l, resizeactive, 10 0
      bind = , Return, submap, reset
      submap = reset
    '';
  };
}
