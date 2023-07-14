{ lib, pkgs, config, ... }: 

{
  wayland.windowManager.sway.config.keybindings =
    let
      modifier = config.wayland.windowManager.sway.config.modifier;

      terminal = config.wayland.windowManager.sway.config.terminal;
      menu = config.wayland.windowManager.sway.config.menu;

      left = config.wayland.windowManager.sway.config.left;
      down = config.wayland.windowManager.sway.config.down;
      up = config.wayland.windowManager.sway.config.up;
      right = config.wayland.windowManager.sway.config.right;

    in lib.mkOptionDefault {
      "${modifier}+Return" = "exec ${terminal}";
      "${modifier}+Shift+q" = "kill";
      "${modifier}+d" = "exec ${menu}";

      "${modifier}+${left}" = "focus left";
      "${modifier}+${down}" = "focus down";
      "${modifier}+${up}" = "focus up";
      "${modifier}+${right}" = "focus right";

      "${modifier}+Left" = "focus left";
      "${modifier}+Down" = "focus down";
      "${modifier}+Up" = "focus up";
      "${modifier}+Right" = "focus right";

      "${modifier}+Shift+${left}" = "move left";
      "${modifier}+Shift+${down}" = "move down";
      "${modifier}+Shift+${up}" = "move up";
      "${modifier}+Shift+${right}" = "move right";

      "${modifier}+Shift+Left" = "move left";
      "${modifier}+Shift+Down" = "move down";
      "${modifier}+Shift+Up" = "move up";
      "${modifier}+Shift+Right" = "move right";

      "${modifier}+b" = "splith";
      "${modifier}+v" = "splitv";
      "${modifier}+f" = "fullscreen toggle";
      "${modifier}+a" = "focus parent";

      "${modifier}+s" = "layout stacking";
      "${modifier}+w" = "layout tabbed";
      "${modifier}+e" = "layout toggle split";

      "${modifier}+Shift+space" = "floating toggle";
      "${modifier}+space" = "focus mode_toggle";

      "${modifier}+1" = "workspace number 1";
      "${modifier}+2" = "workspace number 2";
      "${modifier}+3" = "workspace number 3";
      "${modifier}+4" = "workspace number 4";
      "${modifier}+5" = "workspace number 5";
      "${modifier}+6" = "workspace number 6";
      "${modifier}+7" = "workspace number 7";
      "${modifier}+8" = "workspace number 8";
      "${modifier}+9" = "workspace number 9";
      "${modifier}+0" = "workspace number 10";

      "${modifier}+Shift+1" =
        "move container to workspace number 1";
      "${modifier}+Shift+2" =
        "move container to workspace number 2";
      "${modifier}+Shift+3" =
        "move container to workspace number 3";
      "${modifier}+Shift+4" =
        "move container to workspace number 4";
      "${modifier}+Shift+5" =
        "move container to workspace number 5";
      "${modifier}+Shift+6" =
        "move container to workspace number 6";
      "${modifier}+Shift+7" =
        "move container to workspace number 7";
      "${modifier}+Shift+8" =
        "move container to workspace number 8";
      "${modifier}+Shift+9" =
        "move container to workspace number 9";
      "${modifier}+Shift+0" =
        "move container to workspace number 10";

      "${modifier}+Shift+minus" = "move scratchpad";
      "${modifier}+minus" = "scratchpad show";

      "${modifier}+Shift+c" = "reload";
      "${modifier}+Shift+e" =
        "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

      "${modifier}+r" = "mode resize";

      "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
      "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
      "XF86AudioMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

      "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 5%+";
      "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";

      "${modifier}+F10" = "exec ${pkgs.swaylock}/bin/swaylock -fFi ~/Pictures/wallpaper.* fill";

      # TODO use grimshot instead

      "Print" = "exec --no-startup-id ${pkgs.grim}/bin/grim";
      "${modifier}+Shift+s" = "exec --no-startup-id ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" ~/Pictures/final.jpeg";
  };
}
