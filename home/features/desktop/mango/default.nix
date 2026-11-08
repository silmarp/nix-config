{ inputs, pkgs, lib, config, ... }:
let
  xdg-desktop-portal-wlr = pkgs.xdg-desktop-portal-wlr.overrideAttrs {
    postInstall = ''
        wrapProgram $out/libexec/xdg-desktop-portal-wlr --prefix PATH ":" ${
          lib.makeBinPath [
            pkgs.bash
            pkgs.grim
            pkgs.slurp
            pkgs.rofi
          ]
        }
      '';
  };

in{
  imports = [
    inputs.mangowm.hmModules.mango
  ];

  xdg.portal = {
    enable = true;
    config = {
      common.default = "wlr";
    };
    # xdgOpenUsePortal = true;
    extraPortals = [
      xdg-desktop-portal-wlr
    ];
  };

  wayland.windowManager.mango = {
    enable = true;

    # Temporary for testing configuration without a full rebuild
    # TODO remove this
    extraConfig = ''
      source=~/.config/mango/dinamic.conf
    '';

    settings = {
      bind = [
        # Spawn and kill
        "SUPER,Q,killclient"

        "SUPER,Return,spawn,${lib.getExe pkgs.kitty}"
        "SUPER,d,spawn,${lib.getExe pkgs.rofi} -show drun"
        "SUPER,m,spawn,${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.yazi}"

        # Movement
        "SUPER,left,focusdir,left"
        "SUPER,right,focusdir,right"
        "SUPER,up,focusdir,up"
        "SUPER,down,focusdir,down"

        "SUPER,h,focusdir,left"
        "SUPER,l,focusdir,right"
        "SUPER,k,focusdir,up"
        "SUPER,j,focusdir,down"

        # Tags
        "SUPER,1,view,1"
        "SUPER,2,view,2"
        "SUPER,3,view,3"
        "SUPER,4,view,4"
        "SUPER,5,view,5"
        "SUPER,6,view,6"
        "SUPER,7,view,7"
        "SUPER,8,view,8"
        "SUPER,9,view,9"
        "SUPER,0,view,0"

        "SUPER+SHIFT,1,tag,1"
        "SUPER+SHIFT,2,tag,2"
        "SUPER+SHIFT,3,tag,3"
        "SUPER+SHIFT,4,tag,4"
        "SUPER+SHIFT,5,tag,5"
        "SUPER+SHIFT,6,tag,6"
        "SUPER+SHIFT,7,tag,7"
        "SUPER+SHIFT,8,tag,8"
        "SUPER+SHIFT,9,tag,9"
        "SUPER+SHIFT,0,tag,0"

        "NONE,Print,spawn_shell,${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getBin pkgs.wl-clipboard}/bin/wl-copy"
        "Shift,Print,spawn_shell,${lib.getExe pkgs.grim} - | ${lib.getBin pkgs.wl-clipboard}/bin/wl-copy"

      ];

      xkb_rules_layout="br";
      devicerule = [
        "name:squalius-cephalus-silakka54:kb_layout:br"
      ];

      borderpx = 4;
      gappih   = 5;
      gappiv   = 5;
      gappoh   = 5;
      gappov   = 5;
    };

    autostart_sh = ''
      ${lib.getExe pkgs.swaybg} -m fill -i  ${config.wallpaper} &
    '';

    systemd = {
      enable = true;

      xdgAutostart = true;

      extraCommands = [
        "systemctl --user reset-failed"
        "systemctl --user start mango-session.target"
      ];

      variables = [
        "DISPLAY"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
        "XDG_SESSION_TYPE"
        "NIXOS_OZONE_WL"
        "XCURSOR_THEME"
        "XCURSOR_SIZE"
      ];
    };
  };
}
