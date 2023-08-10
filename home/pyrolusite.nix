{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  imports = [ 
    ./global

    ./features/taskwarrior
    ./features/neovim

    # TODO move to wayland desktop folder
    ./features/sway
    ./features/mako 
    ./features/wofi

    ./features/zsh
    ./features/alacritty
  ];

  home.packages = with pkgs; [
      # TODO remove or move to games section  
      # -------
      zsnes2 
      osu-lazer
      wine
      steam
      prismlauncher
      lutris
      # -------
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
      zk # Note taking/ knowledge management app
      libreoffice # Office suit
  ];
}
