{ inputs, config, pkgs, ... }:

let
  libContrib = inputs.nix-colors.lib-contrib { inherit pkgs;};
in
{
  gtk = {
    enable = true;
    theme = {
      name = "${config.colorscheme.slug}";
      package = libContrib.gtkThemeFromScheme { scheme = config.colorscheme; };
    };
  };
}
