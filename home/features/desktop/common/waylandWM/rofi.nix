{ config, pkgs, ... }:

let palette = config.colorScheme.palette;
in {
  programs.rofi = {
    enable = true;

    # TODO change font
    font = "JetBrainsMono Nerd Font 10";
    location = "center";
    #terminal = "";
    #extraConfig = {};
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      configuration = {
        modi = "drun";
        show-icons = true;
        window-format = "{w}{t}";
        icon-theme = "Tela-circle-dracula";
      };
      # main
      window = {
        height = mkLiteral "50%";
        width = mkLiteral "50%";
        transparency = "real";
        fullscreen = false;
        enabled = true;
        cursor = "default";
        spacing = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "2px";
        border-radius = mkLiteral "40px";
        border-color = mkLiteral "#${palette.base00}";
        background-color = mkLiteral "transparent";
      };
      mainbox = {
        enabled = true;
        spacing = mkLiteral "0px";
        orientation = mkLiteral "horizontal";
        children = [ "inputbar" "listbox" ];
        background-color = mkLiteral "transparent";
        background-image = mkLiteral ''url("${config.wallpaper}", height)'';
      };
      # Inputs
      inputbar = {
        enabled = true;
        width = mkLiteral "30%";
        children = [ "entry" ];
        background-color = mkLiteral "transparent";
        background-image = mkLiteral ''url("${config.wallpaper}", height)'';
      };
      entry = { enabled = false; };

      button = {
        cursor = mkLiteral "pointer";
        border-radius = mkLiteral "50px";
        background-color = mkLiteral "#${palette.base00}";
        text-color = mkLiteral "#${palette.base05}";
      };

      "button selected" = {
        background-color = mkLiteral "#${palette.base05}";
        text-color = mkLiteral "#${palette.base00}";
      };
      # Lists 
      listbox = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "30px";
        children = [ "listview" ];
        background-color = mkLiteral "#${palette.base00}";
      };
      listview = {
        enabled = true;
        columns = 1;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        cursor = "default";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#${palette.base05}";
      };
      # Elements
      element = {
        enabled = true;
        spacing = mkLiteral "30px";
        padding = mkLiteral "8px";
        border-radius = mkLiteral "20px";
        cursor = mkLiteral "pointer";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#${palette.base05}";
      };
      "element selected.normal" = {
        background-color = mkLiteral "#${palette.base02}";
        text-color = mkLiteral "#${palette.base0E}";
      };
      element-icon = {
        size = mkLiteral "48px";
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
      element-text = {
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
    };
  };
}
