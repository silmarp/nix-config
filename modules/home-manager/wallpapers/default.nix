{ lib, ... }:

{
  options.wallpapers = {
    path = lib.mkOption {
      type = lib.types.path;
      default = "";
      description = ''
        Wallpaper path
      '';
    };
  };
}
