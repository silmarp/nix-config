{ config, pkgs, lib, ... }:

let
  palette = config.colorScheme.palette;

  alacritty-xterm = pkgs.writeShellScriptBin "xterm" ''
    ${config.programs.alacritty.package}/bin/alacritty $@
  '';
in
{
  home = {
    packages = [ alacritty-xterm ];
    sessionVariables = {
      TERMINAL = "alacritty";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 14;
        normal = {
          family = "MapleMono";
          style = "Regular";
        };
      };
      colors = {
        # Default colors
        primary = {
          background = "#${palette.base00}";
          foreground = "#${palette.base05}";
        };

        # Normal colors
        normal = {
          black =   "#${palette.base04}";
          red =     "#${palette.base0F}";
          green =   "#${palette.base0B}";
          blue =    "#${palette.base0C}";
          magenta = "#${palette.base0E}";
          cyan =    "#${palette.base0D}";
          white =   "#${palette.base04}";
        };

        # Bright colors
        bright = {
          black =   "#${palette.base04}";
          red =     "#${palette.base0F}";
          green =   "#${palette.base0B}";
          blue =    "#${palette.base0C}";
          magenta = "#${palette.base0E}";
          cyan =    "#${palette.base0D}";
          white =   "#${palette.base04}";
        };
      };
    };
  };
}
