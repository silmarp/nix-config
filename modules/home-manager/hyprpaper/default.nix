{ pkgs, config, lib, ... }:

let
  cfg = config.programs.hyprpaper;
in
{
  options.programs.hyprpaper = {
    enable = lib.mkEnableOption "hyprpaper";
    #package = lib.mkPackageOption pkgs "hyprpaper" { };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hyprpaper;
      defaultText = lib.literalExpression "pkgs.hyprpaper";
      description = "The package to use for the hyprpaper binary";
    };
    settings = lib.mkOption {
      type = with lib.types;
        let
          valueType = nullOr (oneOf [
            bool
            int
            float
            str
            path
            (attrsOf valueType)
            (listOf valueType)
          ]) // {
            description = "Hyprpaper configuration value";
          };
        in valueType;
      default = { };
      description = ''
      '';
      example = lib.literalExpression ''
      '';
    };
  };
  
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    /*
    xdg.configFile."hypr/hyprland.conf" = let
      shouldGenerate = cfg.settings != { };
    */

    xdg.configFile."hypr/hyprpaper.conf" = let
      shouldGenerate = cfg.settings != { };

      toHyprconf = with lib;
        attrs: indentLevel:
        let
          indent = concatStrings (replicate indentLevel "  ");

          mkSection = n: attrs: ''
            ${indent}${n} {
            ${toHyprconf attrs (indentLevel + 1)}${indent}}
          '';
          sections = filterAttrs (n: v: isAttrs v) attrs;

          mkFields = generators.toKeyValue {
            listsAsDuplicateKeys = true;
            inherit indent;
          };

          allFields = filterAttrs (n: v: !(isAttrs v)) attrs;
          importantFields = filterAttrs (n: _:
            (hasPrefix "$" n) || (hasPrefix "bezier" n)) allFields;
          fields = builtins.removeAttrs allFields
            (mapAttrsToList (n: _: n) importantFields);
        in mkFields importantFields
        + concatStringsSep "\n" (mapAttrsToList mkSection sections)
        + mkFields fields;

    in lib.mkIf shouldGenerate {
      text = lib.optionalString (cfg.settings != { }) (toHyprconf cfg.settings 0);

    };
  };
}
