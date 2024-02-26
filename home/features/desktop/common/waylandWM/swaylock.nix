{ pkgs, config, ... }: 

let
  palette = config.colorScheme.palette;
in 
{
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    settings = {
      image = "${config.wallpaper}";
      effect-blur = "7x5";
      clock = true;
      indicator = true;
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      show-failed-attempts = true;
      daemonize = true;

      line-color = "#${palette.base01}";
			ring-color = "#${palette.base0C}";
			key-hl-color = "#${palette.base0D}";
			inside-color = "#${palette.base02}88";
    };
  };
}
