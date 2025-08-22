{ pkgs, config, ... }:

let
  palette = config.colorScheme.palette;
in
{

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    # font = {
    #   package = pkgs.maple-mono.NF;
    #   name = "MapleMono";
    #   size = 16;
    # };
    shellIntegration = {
      enableBashIntegration = true;
    };
    settings = {
      background = "#${palette.base00}";
      foreground = "#${palette.base05}";

      #black
      color0 =   "#${palette.base04}";
      color8 =   "#${palette.base04}";

      #red
      color1 =     "#${palette.base0F}";
      color9 =     "#${palette.base0F}";

      #green
      color2 =   "#${palette.base0B}";
      color10 =   "#${palette.base0B}";

      #blue
      color4 =    "#${palette.base0C}";
      color12 =    "#${palette.base0C}";

      #magenta
      color5 = "#${palette.base0E}";
      color13 = "#${palette.base0E}";

      #cyan
      color6 =    "#${palette.base0D}";
      color14 =    "#${palette.base0D}";

      #white
      color7 =   "#${palette.base04}";
      color15 =   "#${palette.base04}";
 
    };
  };
}
