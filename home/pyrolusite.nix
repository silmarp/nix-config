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
      wl-clipboard # TODO move to sway/wayland config

      rnix-lsp
      nodePackages.bash-language-server

      gimp
      helix # TODO make config
      calcurse
      neomutt # email client
      feh # image viewer
      rssguard # RSS feed reader
      zathura # TODO make config
      spotifyd
      spotify-tui
      kabmat
      bitwarden
      ferdium
      (tor-browser-bundle-bin.override {
        useHardenedMalloc = false;
       })
      element-desktop
      rage # encryption tool
      libreoffice # Office suit

      spotify
  ];
}
