{ ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
          # Enable userChrome customizations
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
