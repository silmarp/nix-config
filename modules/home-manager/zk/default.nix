{ config, lib, pkgs, ... }:

let
  cfg = config.programs.zk;
  tomlFormat = pkgs.formats.toml { };

in {
  options.programs.zk = {
    enable = lib.mkEnableOption "zk";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zk;
      defaultText = lib.literalExpression "pkgs.zk";
      description = "The package to use for the zk binary";
    };

    settings = lib.mkOption {
      type = tomlFormat.type;
      default = { };
      example = pkgs.literalExpression ''
        note = {
          language = "en";
          default-title = "Untitled";
          filename = "{{id}}-{{slug title}}";
          extension = "md";
          template = "default.md";
          id-charset = "alphanum";
          id-length = 4;
          id-case = "lower";
        };
        extra = {
          author = "Mickaël";
        };
      '';
      description = ''
        Configuration written to $XDG_CONFIG_HOME/zk/config.toml.

        See https://github.com/mickael-menu/zk/blob/main/docs/config.md for available options and documentation.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."zk/config.toml" = lib.mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "config.toml" cfg.settings;
    };
  };
}
