{ config, ... }:

{
  programs.qutebrowser = {
    enable = true;
    settings = {
      colors = {
        # Becomes either 'dark' or 'light', based on your colors!
        webpage.preferred_color_scheme = "${config.colorScheme.kind}";
        tabs.bar.bg = "#${config.colorScheme.colors.base00}";
        keyhint.fg = "#${config.colorScheme.colors.base05}";
        # ...
      };
    };
  };
}