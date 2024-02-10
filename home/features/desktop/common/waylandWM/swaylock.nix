{ pkgs, config, ... }: 

let
  colors = config.colorScheme.colors;
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

      line-color = "#${colors.base01}";
			ring-color = "#${colors.base0C}";
			key-hl-color = "#${colors.base0D}";
			inside-color = "#${colors.base02}88";
    };
  };
}
