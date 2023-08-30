{ config, lib, pkgs, ... }:

let
  cfg = config.programs.zk;
  tomlFormat = pkgs.formats.toml { };
in

{
  options.programs.zk = {
    enable = lib.mkEnableOption "zk";
    
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zk;
      defaultText = lib.literalExpression "";
      description = "The package to use for the zk binary";
    };

    settings = lib.mkOption {
      type = tomlFormat.type;
      default = { };
      example = pkgs.literalExpression ''
      '';
      description = ''
      '';
    };

    # TODO make templates
    # completion ?
  };
  
  config = lib.mkIf cfg.enable {
    xdg.configFile."zk/config.toml" = lib.mkIf (cfg.settings != {}) {
      source = tomlFormat.generate "config.toml" cfg.settings;
    };
  };
}
