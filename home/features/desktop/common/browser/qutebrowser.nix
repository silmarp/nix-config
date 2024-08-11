{ config, ... }:

{
  programs.qutebrowser = {
    enable = true;
    settings = {
      tabs.show = "switching";
      colors = {
        # Becomes either 'dark' or 'light', based on your colors!
        webpage.preferred_color_scheme = "${config.colorScheme.variant}";
        tabs.bar.bg = "#${config.colorScheme.palette.base00}";
        keyhint.fg = "#${config.colorScheme.palette.base05}";
        # ...
      };
      content.pdfjs = true;
    };
    keyBindings = {
      normal = {
        "J" = "tab-prev";
        "K" = "tab-next";
      };
    };
  };
}
