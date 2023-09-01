{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  imports = [ 
    ./global

    ./features/taskwarrior
    ./features/neovim

    # TODO move to wayland desktop folder
    ./features/desktop/sway
    ./features/mako 
    ./features/wofi

    ./features/zsh
    ./features/alacritty

    ./features/games

    ./features/common/gtk.nix
    ./features/zk.nix
  ];

  home.packages = with pkgs; [
      htop
      firefox-wayland # TODO make config
      qutebrowser
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
      zellij
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


      zk # Note taking/ knowledge management app
      fzf # ZK needs fzf for some funcitons
      bat



      spotify
  ];
}
