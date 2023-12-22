{ lib, pkgs, config, ... }: 

let
  inherit (config.colorscheme) colors;
in
{
  services.mako = {
    enable = true;
    anchor = "top-right";
    layer = "top";

    #font = "monospace 10";
    backgroundColor = "#${colors.base00}dd";
    borderColor = "#${colors.base03}dd";
    textColor = "#${colors.base05}dd";
    # TODO redo color config
    #progressColor = "#${colors.base08}dd";

    extraConfig = ''
    '';

    format = "<b>%s</b>\\n%b";

    borderRadius = 0;
    borderSize = 1;
    margin = "10";

    defaultTimeout = 12000;
    ignoreTimeout = false;

    height = 150;
    width = 400;

    iconPath = null;
    icons = true;
  };
}
