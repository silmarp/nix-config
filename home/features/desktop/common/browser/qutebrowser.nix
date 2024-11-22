{ config, ... }:

{
  programs.qutebrowser = {
    enable = true;
    settings = {
      tabs.show = "never";
      tabs.position = "left";
      colors = {
        # Becomes either 'dark' or 'light', based on your colors!
        webpage.preferred_color_scheme = "${config.colorScheme.variant}";
        tabs.bar.bg = "#${config.colorScheme.palette.base00}";
        keyhint.fg = "#${config.colorScheme.palette.base05}";
        # ...
      };
      content.pdfjs = true;
      url.start_pages = ["nextcloud.silmarp.dev"];
    };
    keyBindings = {
      normal = {
        "tt" = "config-cycle tabs.show always never";
      };
    };
  };
}
