{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  imports = [ 
    ./global

    ./features/neovim

    ./features/desktop/sway

    ./features/games

    ./features/productivity

    ./features/cli
  ];

  home.packages = with pkgs; [
      discord
      
      rnix-lsp
      nodePackages.bash-language-server

      helix # TODO make config
      feh # image viewer TODO make separate config
      rssguard # RSS feed reader
      zathura # TODO make config
      kabmat
      bitwarden
      tor-browser-bundle-bin
      element-desktop
      rage # encryption tool
      libreoffice # Office suit

      spotify
  ];
}
