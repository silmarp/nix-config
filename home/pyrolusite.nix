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

  config.wallpaper.path = builtins.fetch{
    url = "https://i.stack.imgur.com/cmoDG.jpg";
    sha256 = "0f701igjzh8593if7z0hzx1aj7cy0c9i0vscs1pdcp16ibp2vy14";
  };

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
      tor-browser-bundle-bin
      element-desktop
      rage # encryption tool
      libreoffice # Office suit

      spotify

      thunderbird

  ];
}
