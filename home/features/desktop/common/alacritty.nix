{ config, pkgs, lib, ... }:

let
  colors = config.colorScheme.colors;

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
          background = "#${colors.base00}";
          foreground = "#${colors.base05}";
        };

        # Normal colors
        normal = {
          black =   "#${colors.base04}";
          red =     "#${colors.base0F}";
          green =   "#${colors.base0B}";
          blue =    "#${colors.base0C}";
          magenta = "#${colors.base0E}";
          cyan =    "#${colors.base0D}";
          white =   "#${colors.base04}";
        };

        # Bright colors
        bright = {
          black =   "#${colors.base04}";
          red =     "#${colors.base0F}";
          green =   "#${colors.base0B}";
          blue =    "#${colors.base0C}";
          magenta = "#${colors.base0E}";
          cyan =    "#${colors.base0D}";
          white =   "#${colors.base04}";
        };
      };
    };
  };
}
