{ inputs, config, pkgs, ... }:

let
  libContrib = inputs.nix-colors.lib-contrib { inherit pkgs;};
in
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "${config.colorscheme.slug}";
      package = libContrib.gtkThemeFromScheme { scheme = config.colorscheme; };
    };
  };
}
