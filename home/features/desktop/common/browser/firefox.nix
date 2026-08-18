{ config, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.default = {
      isDefault = true;
      settings = {
          # Enable userChrome customizations
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
